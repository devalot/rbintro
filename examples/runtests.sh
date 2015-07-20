#!/bin/sh -e

################################################################################
# This file is part of the package effrb. It is subject to the license
# terms in the LICENSE.md file found in the top-level directory of
# this distribution and at https://github.com/pjones/effrb. No part of
# the effrb package, including this file, may be copied, modified,
# propagated, or distributed except according to the terms contained
# in the LICENSE.md file.

base=`dirname $0`
RB_VERSIONS=`cat $base/ruby-versions.txt`
export PATH=$HOME/.rbenv/bin:$PATH

install () {
  if ! rbenv prefix $1 > /dev/null; then
      rbenv install $ver
  fi
}

run_test () {
  bundle install
  rbenv rehash

  bundle exec rake test
  bundle exec rake spec
}

for ver in $RB_VERSIONS; do
  install $ver

  export RBENV_VERSION=$ver
  eval "`rbenv init -`"

  if ! rbenv which bundle > /dev/null 2>&1; then
      gem install bundler
  fi

  rbenv rehash

  printf "====> RUBY_VERSION: "
  ruby -v

  OUT=`run_test 2>&1`
  [ $? -ne 0 ] && echo "$OUT" && exit 1

  echo "$OUT" | egrep '(warning|^[0-9]+ tests,)' | \
    grep -Fv "syntax/candy_bar_test.rb:103" | \
    grep -Fv "all_objects/super_test.rb:33" | \
    grep -Fv "all_objects/super_test.rb:24"
done
