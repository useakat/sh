#!/bin/bash

x=$1
scale=$2

x=`echo $x | tr '[:upper:]' '[:lower:]'`
r=${x%%e*}
epm=${x##*e}

if [ $epm != $x ];then
    e=${epm##+}
    e=${e##-}
    pm=${epm%%${e}}
    
    if [ -z "$pm" ];then 
	base=10
    else
	if [ ${pm} == "+" ]; then
	    base=10
	elif [ ${pm} == "-" ]; then 
	    base=0.1
	fi
    fi
    
    echo "scale=${scale}; ${r}*${base}^(${e})" | bc | sed 's/^\./0./'
else
    echo $x | sed 's/^\./0./'
fi