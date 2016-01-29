#!/bin/bash
if [[ "$1" == "-h" ]]; then
    echo ""
    echo "Usage: branch.sh [ext]"
    echo ""
    echo " [ext] extention for the branch dir"
    echo ""
    exit
fi

ext=$1

path=`pwd`
cdir=${path##*/}
bdir=${cdir}_${ext}

cd ..
bzr branch $cdir $bdir





    