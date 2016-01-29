#!/bin/bash
if [[ "$1" == "-h" ]]; then
    echo ""
    echo "Usage: write_lines.sh [file]"
    exit
fi

file=$1
newfile="echo_$1"

if [ -e $newfile ]; then
    rm -rf $newfile
fi
touch $newfile

sed -e 's/^/      write(1,*) "/'  $file > tmp_$file
sed -e 's/$/"/' tmp_$file > echo_$file

rm -rf tmp_$file
    