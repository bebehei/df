#!/bin/sh

# ignores the nasty doc/tags
# when vim starts, pathogen generates doc/tags in every submodule.
# Here, we update the exclude files to ignore them.

find .git/modules -name info -type d \
	| while read dir; do

	grep doc/tags $dir/exclude \
		|| (echo 'doc/tags' >> $dir/exclude)

done
