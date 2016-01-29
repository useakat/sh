#!/bin/bash
if [[ "$1" == "-h" ]]; then
    echo ""
    echo "Usage: echo_line.sh [file]"
    exit
fi

file=$1
newfile="echo_$1"

if [ -e $newfile ]; then
    rm -rf $newfile
fi
touch $newfile

sed -e 's/^/echo "/'  $file > tmp_$file
sed -e 's/$/" >> ${out_file}/' tmp_$file > echo_$file

rm -rf tmp_$file

    