#!/bin/sh
#rubygems path
if which ruby 2>&1 >/dev/null && which gem 2>&1 >/dev/null; then
    PATH="$(ruby -rubygems -e 'puts Gem.user_dir')/bin:$PATH"
fi
