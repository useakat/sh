#!/bin/bash
if [[ "$1" == "-h" ]]; then
    echo ""
    echo "Usage: dldir_ez.sh [file] [host]"
    echo ""
    echo " [file] the file to be downloaded"
    echo ""
    echo " [host] name or the adress of the host server with the login name"
    echo "        ex) user@host.com"
    exit
fi
file=$1
host=$2

rmpath=$STUDY
path=`pwd`
dir=${path##${rmpath}/}

dldir.sh $host ${dir}/${file}