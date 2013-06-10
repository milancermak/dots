# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

PS1='\[\033[01;32m\]\u:\[\033[01;34m\]\w\[\033[00m\] \[\033[01;33m\]$(__git_ps1 "(%s)")\[\033[00m\] '

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi
export LSCOLORS=gxfxcxdxbxegedabagacad

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# moar completion
if [ -f /opt/local/etc/bash_completion ]; then
      . /opt/local/etc/bash_completion
fi
if [ -f /usr/local/etc/bash_completion ]; then
      . /usr/local/etc/bash_completion
fi

export EDITOR='zile'
export GREP_OPTIONS='--exclude=*.pyc --exclude-dir=.git'

# virtualenv & python options
export PIP_RESPECT_VIRTUALENV=true
export VIRTUALENV_USE_DISTRIBUTE=true

# AWS CLI tools
export JAVA_HOME=$(/usr/libexec/java_home)
export AWS_CREDENTIAL_FILE=~/bin/aws/cred
export AWS_IAM_HOME=~/bin/aws/iam
export AWS_ELB_HOME=~/bin/aws/elb
AWS_BIN_PATHS=$AWS_IAM_HOME/bin:$AWS_ELB_HOME/bin
export PATH=$AWS_BIN_PATHS:~/bin:/usr/local/bin:/usr/local/sbin:$PATH:$HOME/.rvm/bin

# for Openpilot dev
PATH=$PATH:~/QtSDK/Desktop/Qt/4.8.1/gcc/bin:~/bin/gcc-arm-none-eabi-4_7-2013q1

# for iOS dev
IPHONE_SDK_FRAMEWORKS_DIR=/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS6.1.sdk/System/Library/Frameworks
