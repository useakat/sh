#!/bin/bash
if [[ "$1" == "-h" ]]; then
    echo ""
    echo "Usage: dl.sh (-f) [path] [host]"
    echo ""
    echo " [path] path to the file to be downloaded"
    echo ""
    echo " [host] name or the adress of the host server with the login name"
    echo "        ex) user@host.com"
    echo ""
    echo " f: download file(path) from same directory in the host"
    exit
fi

host=$2
dir=""
while getopts f opt
do
    case ${opt} in
	f)
	    cur_dir=`pwd`
	    dir=${cur_dir##*projects/}/;;
	*)
	    exit 1;;
    esac
done
shift $(( $OPTIND -1 ))
path=$dir$1

if [[ $host == "heg" ]]; then
    scp -r yoshitar@heget.kek.jp:$path .
elif [[ $host == "kek" ]]; then
    scp -r takaesu@login.cc.kek.jp:$path .
elif [[ $host == "ing" ]]; then
    ssh ytakaesu@server02.fynu.ucl.ac.be "dl.sh $path ing"
    scp -r takaesu@ingrid-ui1.cism.ucl.ac.be: .
elif [[ $host == "ucl" ]]; then
    scp -r ytakaesu@server02.fynu.ucl.ac.be:$path .
elif [[ $host == "sak" ]]; then
    scp -r useakat@133.242.151.135:$path .
else     
    scp -r $host:$path .
fi