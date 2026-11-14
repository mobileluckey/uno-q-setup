#!/bin/bash
# snap.sh - take a picture with the IMX219 camera
# Usage: snap.sh [name]

export TZ=America/Chicago
NAME=${1:-snap-$(date +%Y%m%d-%H%M%S)}
TMP=/tmp/snap
OUT="$HOME/Pictures/$NAME.jpg"

mkdir -p "$TMP"
rm -f "$TMP"/frame-*.bin

sudo cam -c 1 -s width=640,height=480 --capture=20 --file="$TMP/frame-#.bin" > "$TMP/cam.log" 2>&1

LAST=$(ls "$TMP"/frame-*.bin 2>/dev/null | tail -n 1)
if [ -z "$LAST" ]; then
	echo "Capture failed. See $TMP/cam.log"
	exit 1
fi

magick -size 632x480 -depth 8 rgba:"$LAST" "$OUT"
echo "Saved $OUT"

if [ -n "$DISPLAY" ]; then
	xdg-open "$OUT" &
fi
