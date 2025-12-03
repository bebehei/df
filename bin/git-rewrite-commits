#!/usr/bin/env bash

# Automatically start a rebase for all commits between HEAD and the main
# branch without integrating new commits from the main branch
#
# Technically it's a git rebase without rebasing any commits.

# Enforce being in a git repository
git rev-parse --is-inside-work-tree >/dev/null || exit $?

HEAD_REMOT="$(git rev-parse --abbrev-ref origin/HEAD | cut -d/ -f2)"
HEAD_LOCAL="$(git rev-parse --abbrev-ref        HEAD)"

if [ "${HEAD_LOCAL}" = "${HEAD_REMOT}" ]; then
    echo "Cannot rebase commits from '${HEAD_LOCAL}' (HEAD) onto '${HEAD_REMOT}'" >&2
    exit 1
fi

MERGE_BASE="$(git merge-base "${HEAD_REMOT}" HEAD)"

# Show the next command
set -x

git rebase --interactive "${MERGE_BASE}"
