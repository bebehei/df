#!/bin/sh

if [ -z "${IN_NIX_SHELL}" ]; then
	LP_ENABLE_TITLE=1
	LP_ENABLE_SSH_COLORS=1
	LP_ENABLE_VCS_ROOT=1
	LP_DISABLED_VCS_PATH=""
	LP_ENABLE_TEMP=0
	LP_ENABLE_BATT=0
	LP_ENABLE_SUDO=1
	LP_ENABLE_LOAD=1

	# Show the time for commands executing longer than five seconds
	LP_ENABLE_RUNTIME=1
	LP_ENABLE_RUNTIME_THRESHOLD=5

	# Ring the bell after termination for commands running longer than a minute
	# It's likely that I switched away in the meantime
	LP_ENABLE_RUNTIME_BELL=1
	LP_ENABLE_RUNTIME_BELL_THRESHOLD=60
	source ~/.liquidprompt/liquidprompt
fi
