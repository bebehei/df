#!/bin/sh

# array to process, either folders or directories for recursive processing
KEYPATHS+=("$HOME/.ssh/keys")

if command -v keychain 2>&1 >/dev/null; then
	eval \
		`find ${KEYPATHS[@]} -type f -not -name '*.pub' 2>/dev/null \
		| xargs keychain -q --nogui --agents ssh --timeout 600 --eval`
fi
unset KEYPATHS
