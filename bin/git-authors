#!/bin/sh

# Enforce being in a git repository
git rev-parse --is-inside-work-tree >/dev/null || exit $?

# save as i.e.: git-authors and set the executable flag
git ls-tree -r -z --name-only HEAD -- "${1}" \
  | xargs -0 -n1 git blame --line-porcelain HEAD \
  | grep  "^author " \
  | sort \
  | uniq -c \
  | sort -nr
