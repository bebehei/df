#!/bin/sh
function set_path(){
	if [[ -d "$1" ]]; then
		export PATH=$1:$PATH
	fi
}

set_path ~/.local/bin/
set_path ~/.bin

if which ruby >/dev/null 2>&1 && which gem >/dev/null 2>&1; then
    set_path $(ruby -rubygems -e 'puts Gem.user_dir')/bin
fi

# PERL cpan modules
set_path $HOME/.perl/5/bin
export PERL5LIB="$HOME/.perl/5/lib/perl5:$PERL5LIB"
export PERL_LOCAL_LIB_ROOT="$HOME/.perl/5:$PERL_LOCAL_LIB_ROOT"
export PERL_MB_OPT="--install_base \"$HOME/.perl/5\""
export PERL_MM_OPT="INSTALL_BASE=$HOME/.perl/5"

export GOPATH=$HOME/.go
export GOBIN=$HOME/.gobin
set_path $GOPATH/bin
set_path $GOBIN
