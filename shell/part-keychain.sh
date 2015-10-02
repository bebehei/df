#!/bin/sh

# array to process, either folders or directories for recursive processing
KEYPATHS+=("$HOME/.ssh/keys")

eval `find ${KEYPATHS[@]} -type f -not -name '*.pub' | xargs keychain -q --nogui --agents ssh --timeout 600 --eval`
unset KEYPATHS
