#!/bin/sh
sleep 4
env DISPLAY=:0 XAUTHORITY=/var/run/lightdm/root/:0 /usr/bin/xrandr --output DP-1 --mode 1280x720 --rate 60
exit 0
