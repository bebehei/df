#!/bin/sh

# open a Markdown document in your browser directly
# mdo => markdown open

# e.g. preview the markdown in vim:
# :!mdo %

$BROWSER "data:text/html;base64,`markdown $* | base64 -w 0`"
