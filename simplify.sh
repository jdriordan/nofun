#! /bin/sh
# Convert an SMB screeshot to a low-memory version with suiatble
# filename and associated input string.
#
# Takes a button sequence as input, fails if `data` directory doesn't exist

filename=$(mktemp "data/XXXXXXXXXX")
convert current_frame.png -threshold 22% -crop 200x160+50+50 -resize 100x80 $filename.png
echo $1 > $filename
