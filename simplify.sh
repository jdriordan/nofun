#! /bin/sh
# Convert an SMB screeshot to a low-memory version
convert $1 -threshold 22% -crop 200x160+50+50 -resize 100x80 $1
