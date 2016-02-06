# Check for interactive bash (taken from bash_completion-script)

if [ -n "$BASH_VERSION" -a -n "$PS1" ]; then
	# Binds ## 
	bind '"\e[5~": history-search-backward'
	bind '"\e[6~": history-search-forward'

fi
