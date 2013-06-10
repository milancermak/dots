#!/bin/bash

find $IPHONE_SDK_FRAMEWORKS_DIR -name '*.h' | xargs ./yasobjc.rb -o ./objc-mode
