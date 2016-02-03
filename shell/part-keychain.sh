#!/bin/sh

# array to process, either folders or directories for recursive processing
KEYPATHS+=("$HOME/.ssh/keys" "$HOME/.ssh/gitlab_rsa" "$HOME/.ssh/id_rsa")

eval `find ${KEYPATHS[@]} -type f -not -name '*.pub' 2>/dev/null | xargs keychain -q --nogui --agents ssh --timeout 600 --eval`
unset KEYPATHS
