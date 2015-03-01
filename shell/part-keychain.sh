#!/bin/sh

for key in `find ~/.ssh/keys -type f -not -name '*.pub'`; do
    eval `keychain -q --agents ssh --timeout 600 --eval $key`
done
