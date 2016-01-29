#!/bin/bash
if [[ "$1" == "-h" ]]; then
    echo ""
    echo "Usage: "
    echo ""
    exit
fi
#check_updatedir=`cat maindir.txt`
selfdir=$(cd $(dirname $0);pwd)
if [[ $1 = "h" ]]; then
    echo "run name"
    read run
else
    if [ $# -ge 1 ];then
	dir=$1
    fi
fi

cd $dir
echo `pwd`
rsync_check.sh
    
