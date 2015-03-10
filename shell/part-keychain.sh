#!/bin/sh

KEYFOLDERS+=('~/.ssh/keys')

for folder in ${KEYFOLDERS[@]}; do
    if [ -d $folder ]; then
        for key in `find ~/.ssh/keys -type f -not -name '*.pub'`; do
            eval `keychain -q --agents ssh --timeout 600 --eval $key`
        done
    fi
done
