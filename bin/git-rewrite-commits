#!/usr/bin/env bash

# Automatically start a rebase for all commits between HEAD and the main
# branch without integrating new commits from the main branch
#
# Technically it's a git rebase without rebasing any commits.

# Enforce being in a git repository
git rev-parse --is-inside-work-tree >/dev/null || exit $?

# We actually should check out the head branch via `git remote show ${REMOTE}`,
# but this requires active connection and active 2FA verification. Tedious to
# have multiple calls for this
if git rev-parse --verify main &>/dev/null; then
    MAIN_BRANCH=main
else
    MAIN_BRANCH=master
fi

CURRENT_BRANCH="$(git rev-parse --abbrev-ref HEAD)"

if [ "${CURRENT_BRANCH}" = "${MAIN_BRANCH}" ]; then
    echo "Cannot rebase commits from '${CURRENT_BRANCH}' (HEAD) onto '${MAIN_BRANCH}'" >&2
    exit 1
fi

MERGE_BASE="$(git merge-base "${MAIN_BRANCH}" HEAD)"

# Show the next command
set -x

git rebase --interactive "${MERGE_BASE}"
