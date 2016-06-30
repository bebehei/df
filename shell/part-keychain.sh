#!/bin/sh

# array to process, either folders or directories for recursive processing
KEYPATHS+=("$HOME/.ssh/keys")

command -v keychain 2>&1 >/dev/null && eval `find ${KEYPATHS[@]} -type f -not -name '*.pub' 2>/dev/null | xargs keychain -q --nogui --agents ssh --timeout 600 --eval`
unset KEYPATHS
