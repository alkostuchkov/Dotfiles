#!/usr/bin/env bash

# filename=$(stat -c %n)
filename=$1
filetype=$(stat -c %F $filename) 
location=$(pwd)
size=$(du -h --max-depth=0 $filename)
permitions=$(stat -c %A $filename)
owner=$(stat -c %U $filename)
group=$(stat -c %G $filename)
created=$(stat -c %w $filename)
modified=$(stat -c %y $filename)
accessed=$(stat -c %x $filename)
# filesystem=$(stat -c %T $filename)
# mountpoint=$(stat -c %m $filename)

echo
echo "Filename: $1"
echo "Type: $filetype"
echo "Location: $location"
echo
echo "Size: $size"
echo "Permitions: $permitions"
echo "Owner: $owner"
echo "Group: $group"
echo
echo "Created: $created"
echo "Modified: $modified"
echo "Accessed: $accessed"
# echo
# echo "File System: $filesystem"
# echo "Mounted on: $mountpoint"

