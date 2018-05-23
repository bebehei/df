#!/bin/sh

#LP_ENABLE_RUNTIME=1
LP_ENABLE_TITLE=1
LP_ENABLE_SSH_COLORS=1
LP_ENABLE_VCS_ROOT=1
LP_DISABLED_VCS_PATH=""
LP_ENABLE_TEMP=0
LP_ENABLE_BATT=0
LP_ENABLE_SUDO=1
# if in git folder, the prompt takes very long to rebuild
mountpoint $HOME 2> /dev/null > /dev/null && LP_DISABLED_VCS_PATH="$HOME"
source ~/.liquidprompt/liquidprompt
