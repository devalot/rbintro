#!/bin/sh

BASE=`dirname $0`

# Damn IRB includes 2 extra lines!
irb -f --noreadline --simple-prompt -I$BASE -rirbrc.rb $@ 2>&1 \
  | sed -e '1d' -e '$d' | sed -e 's/^>>[[:space:]]*$//' -e 's/^\?>/>>/'
