#!/bin/sh

# Prevent multiple chains of git git <command>

# git git config .... -> git config ....
# git git (git)* config .... -> git config ....

git $*
