#! /bin/bash
#echo "Simplifying!"
convert $1 -threshold 22% -crop 200x160+50+50 -resize 100x80 $2
