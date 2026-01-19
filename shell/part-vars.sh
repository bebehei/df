#!/bin/sh

if [ -n "$(type nvim 2>/dev/null)" ]; then
  export EDITOR=nvim
  export VISUAL=nvim
else
  export EDITOR=vim
  export VISUAL=vim
fi
export BROWSER=firefox
