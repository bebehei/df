#!/bin/bash

case $1 in
	XF86AudioPlay)
		xdotool key --window $(xdotool search --limit 1 --name "Spotify (Premium )?- Linux Preview") $1
		dbus-send --type=method_call --dest=org.mpris.MediaPlayer2.rhythmbox  /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause
	;;
		
	XF86AudioNext)
		xdotool key --window $(xdotool search --limit 1 --name "Spotify (Premium )?- Linux Preview") $1
		dbus-send --type=method_call --dest=org.mpris.MediaPlayer2.rhythmbox  /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next
	;;
		
	XF86AudioPrev)
		xdotool key --window $(xdotool search --limit 1 --name "Spotify (Premium )?- Linux Preview") $1
		dbus-send --type=method_call --dest=org.mpris.MediaPlayer2.rhythmbox  /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous
	;;

	XF86AudioPrev)
		xdotool key --window $(xdotool search --limit 1 --name "Spotify (Premium )?- Linux Preview") $1
		dbus-send --type=method_call --dest=org.mpris.MediaPlayer2.rhythmbox  /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous
	;;
	XF86AudioRaiseVolume)
		pulseaudio-ctl up
	;;
	XF86AudioLowerVolume)
		pulseaudio-ctl down
	;;
	XF86AudioMute)
		pulseaudio-ctl mute
	;;
		
esac
