#!/bin/sh

# array to process, either folders or directories for recursive processing
KEYPATHS+=("$HOME/.ssh/keys" "$HOME/.ssh/id_rsa")

for folder in ${KEYPATHS[@]}; do
    if [ -f "$folder" ]; then
        eval `keychain -q --agents ssh --timeout 600 --eval $folder`
    fi

     if [ -d $folder ]; then
        for key in `find $folder -type f -not -name '*.pub'`; do
            eval `keychain -q --agents ssh --timeout 600 --eval $key`
        done
     fi
done
