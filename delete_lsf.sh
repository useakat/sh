#!/bin/bash

min=$1
max=$2

i=$min
while [ $i -le $max ];do
    rm -rf ~/.lsf/$i.out
    i=`expr $i + 1`
done