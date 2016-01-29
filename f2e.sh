#!/bin/bash

x=$1
scale=$2

gg=`echo "$x >= 0" | bc`
if [ $gg -ne 1 ];then
    x=`echo "scale=${scale}; ${x}*-1" | bc | sed 's/^\./0./'`
    m=1
else
    m=0
fi

sscale=`expr ${scale} + 1`
ff=`echo "$x >= 1" | bc`
if [ $ff -eq 1 ];then
    i=0
    while [ $ff -eq 1 ];do
	x=`echo "scale=${sscale}; ${x}/10" | bc`
	ff=`echo "$x >= 1" | bc`
	i=`expr $i + 1 `
    done
    r=`echo "scale=${sscale}; ${x}*10" | bc`
    r=${r:0:${sscale}}
    e=`expr $i - 1`
    if [ $m -eq 1 ];then
	echo -${r}e+$e
    else
	echo ${r}e+$e
    fi
else
    hh=`echo "$x > 0" | bc`
    if [ $hh -eq 1 ];then    
	i=0
	while [ $ff -ne 1 ];do
	    x=`echo "scale=${sscale}; ${x}*10" | bc`
	    ff=`echo "$x >= 1" | bc`
	    i=`expr $i + 1 `
	done
	r=`echo "$x" | sed 's/^\./0./'`
	r=${r:0:${sscale}}
	e=`expr $i`
	if [ $m -eq 1 ];then
	    echo -${r}e-$e
	else
	    echo ${r}e-$e
	fi
    else
	echo 0
    fi  
fi