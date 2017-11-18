#!/bin/sh

# commands needed:
# cargo
# npm

# This will install YouCompleteMe to vim
# parts of the program are taken from the official Installation Instructions

mkdir -p ~/.vim/bundle-external
cd ~/.vim/bundle-external

git clone https://github.com/Valloric/YouCompleteMe.git
cd YouCompleteMe
git submodule update --init --recursive

PYTHON_BINARY=python
if command -v python2 2>&1 >/dev/null; then
  PYTHON_BINARY=python2
fi

$PYTHON_BINARY ./install.py --clang-completer
