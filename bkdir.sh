#!/bin/bash
if [[ "$1" == "-h" ]]; then
    echo ""
    echo "Usage: fortran_temp.sh [type]"
    echo ""
    echo " [type] template type: pro or sub"
    echo ""
    exit
fi

#set the parameters
date=`date '+%y.%m.%d'`

#get the directory path
if [ $# -gt 0 ]; then
    dir=$1
else
    path=`pwd`    
    dir=`basename $path`
    cd ..
fi

bkdir=${dir}_bk$date
flag=1
i=0
while [ $flag -eq 1 ];do
    if [ $i -eq 0 ];then
	if [ -e $bkdir ];then
	    i=`expr $i + 1`
	else
	    flag=0
	fi
    else
	if [ -e ${bkdir}_$i ];then
	    i=`expr $i + 1`
	else
	    flag=0
	    bkdir=${bkdir}_$i
	fi
    fi
done

cp -rf $dir $bkdir


    