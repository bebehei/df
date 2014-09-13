#!/usr/bin/env bash

KBDLIST=$HOME/.i3/kbdlist

KBDFH=$HOME/.i3/layout_now
KBDNOW=`cat $KBDFH`
KBDNEXT=`head -n 1 $KBDLIST`

savelay=0
for kbd in $(cat $KBDLIST); do
	if [[ "$savelay" != 0 ]]; then
		KBDNEXT=$kbd
		savelay=0
		break
	fi

	if [[ "$KBDNOW" = "$kbd" ]]; then
		savelay=1
	fi
done

setxkbmap $KBDNEXT
echo layout is now $KBDNEXT
echo $KBDNEXT > $KBDFH;
