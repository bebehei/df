#!/bin/sh

# Assert an ssh-agent (which is empty at the beginning)
if command -v keychain 2>&1 >/dev/null; then
	eval $(keychain -q --nogui --timeout 600 --eval)
fi
