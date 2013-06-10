;; update load path
(add-to-list 'load-path (expand-file-name "~/.emacs.d/"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/external/"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/external/ESS/"))
(progn (cd "~/.emacs.d/")
       (normal-top-level-add-subdirs-to-load-path))

;; speak utf-8
(prefer-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(setq file-name-coding-system 'utf-8)
(set-language-environment "UTF-8")
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))
(setq coding-system-for-read 'utf-8)
(setq coding-system-for-write 'utf-8)

;;;
;;; Load & mode
;;;

;; smart & fast completion
(setq partial-completion-mode t)

;; text-mode as default
(setq default-major-mode 'text-mode)

;; enable Ibuffer mode
(require 'ibuffer)

;; interactively do things
(require 'ido)
(ido-mode t)

;; Emacs speaks statistics
;(require 'ess-site)

;; set "coding" as a harmless file variable
;; (disables warnings on opening files with -*- coding: utf-8 -*-
(put 'coding 'safe-local-variable 'symbolp)
(put 'encoding 'safe-local-variable 'symbolp) ;; also for "encoding"

(load "objc.el")
;(load "R.el")
(load "goodies.el")

;;;
;;; Key bindings
;;;

;; make cmd and option keys on a Mac work as Meta
;; the and Fn as Hyper
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'meta)
(setq ns-function-modifier 'hyper)

;; show buffers
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; buffer navigation
(global-set-key (kbd "C-x j") 'other-frame)

;; delete region (cut without killring)
(global-set-key (kbd "C-x C-x") 'delete-region)

;; delete file and buffer
(global-set-key (kbd "C-c D") 'delete-file-and-buffer)

;; remove trailing whitespace and indent neatly
(global-set-key (kbd "C-c n") 'cleanup-buffer-safe)

;; joins split lines to one http://whattheemacsd.com/key-bindings.el-03.html
(global-set-key (kbd "M-j")
            (lambda ()
                  (interactive)
                  (join-line -1)))

;; make it harder to quit Emacs
(global-set-key (kbd "C-x r q") 'save-buffers-kill-terminal)
(global-unset-key (kbd "C-x C-c"))
;; and disable backgrounding
(global-unset-key (kbd "C-z"))

;;;
;;; UI
;;;

;; dark colors
(require 'color-theme)
(color-theme-initialize)
(color-theme-billw)

;; truncate long lines and wrap on word character
(set-default 'truncate-lines nil)
(set-default 'truncate-partial-width-windows nil)
(set-default 'word-wrap nil)

;; font
;; ubuntu:
;;(set-face-font 'default "-*-proggytinyttsz-*-*-*-*-17-*-*-*-*-*-iso10646-*")
;; os x:
(set-face-font 'default "-*-monaco-*-*-*-*-11-*-*-*-*-*-*-*")

;; blinking cursor is easier to locate
(blink-cursor-mode 1)

;; display the time in 24 hour format
(display-time)
(setq display-time-24hr-format t)

;; visual feedback on selections
(setq transient-mark-mode t)

;; highlight pair parens
(show-paren-mode t)

;; don't open files from an external app (e.g. XCode) in new frames, reuse the existing one
(setq ns-pop-up-frames nil)

;; disable scroll & menu & tool bars to have more for the frame content
(set-scroll-bar-mode nil)
(menu-bar-mode -1)
(tool-bar-mode -1)

;; show column numbers
(setq column-number-mode t)

;; indent with space, 4 columns, always
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
(setq indent-line-function 'insert-tab) ;; testing from http://stackoverflow.com/questions/69934/set-4-space-indent-in-emacs-in-text-mode#1819405
(setq tab-stop-list (number-sequence 4 200 4)) ;; http://stackoverflow.com/a/10439239/1370986

;; end all files with \n, as it should be in the first place
(setq require-final-newline t)

;; I hate whitespace at end of lines
(set-default 'show-trailing-whitespace t)

;;;
;;; UX
;;;

;; replace typing yes/no by y/n
(fset 'yes-or-no-p 'y-or-n-p)

;; make the mouse cursor jump away when blocking sight
(mouse-avoidance-mode 'jump)

;; scroll one line at a time when buffer border is hit
(setq scroll-conservatively 1) ; scroll, don't jump

;; don't make ~ backup files
(setq make-backup-files nil)

;; die whitespace
(add-hook 'before-save-hook 'cleanup-buffer-safe)

;; a better way to distinguish between buffers with the same filename
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)
(setq uniquify-min-dir-content 2)
(setq uniquify-separator "/")

;;;
;;; Various
;;;
;; compile init file to save startup time
(defun autocompile nil
  "compile itself if ~/.emacs"
  (interactive)
  (require 'bytecomp)
  (if (string= (buffer-file-name) (expand-file-name
                   (concat default-directory "~/.emacs.d")))
      (byte-compile-file (buffer-file-name))))
(add-hook 'after-save-hook 'autocompile)
