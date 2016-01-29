#!/bin/bash
if [[ "$1" == "-h" ]]; then
    echo ""
    echo "Usage: rsync_pull.sh [cpdir]"
    echo ""
    exit
fi

if [ -e .nosync ];then
    echo ""
    echo "This dir is forbidden to be syncronized"
    echo "Quitting sync ..."
    echo ""
    exit
fi

# server=yoshitar@heget.kek.jp
# server_home=/home/yoshitar
server=useakat@133.242.151.135
server_home=/home/useakat

ikekcc=0
if [ $HOME = "/Users/yoshi" ];then
    rmpath=$STUDY
elif [ $HOME = "/home/th/takaesu" ];then
    ikekcc=1
    rmpath1=/gpfs${HOME}
    rmpath2=${HOME}
elif [ $HOME = "/home/yoshitar" ];then
    rmpath=${HOME}
elif [ $HOME = "/home/fynu/takaesu" ];then
    rmpath=${HOME}
else
    echo ""
    echo "ERROR:This platform is not supported."
    echo ""
fi
ans=y
if [ $# -gt 0  ];then
    cpdir=$1
    if [ -e $cpdir ];then
	echo ""
	echo "directory already exists."
	echo "proceed in the directory? [y/n]"	
	echo ""
	read ans
	if [ $ans = "n" ];then
	    echo "Qitting sync ..."
	    exit
	fi
    else
	mkdir $cpdir
	cd $cpdir
	echo 1 > date.txt
	cd ..
    fi
else
    path=`pwd`
    cpdir=${path##*/}
    cd ..
fi

cd $cpdir
path=`pwd`
if [ $ikekcc -eq 1 ];then
    dir=${path##${rmpath1}/}
    dir=${dir##${rmpath2}/}
else
    dir=${path##${rmpath}/}
fi

ssh ${server} cat ${dir}/date.txt > date_server.txt
read local_date < date.txt
read server_date < date_server.txt
if [ ${local_date} -lt ${server_date} ];then
    rm -rf ../${cpdir}_bk
    cp -rf ../$cpdir ../${cpdir}_bk
    if [ -e .exclude_list ];then
	rsync -avzr --delete --exclude-from '.exclude_list' -e ssh ${server}:${server_home}/${dir} ../
    else
	rsync -avzr --delete -e ssh ${server}:${server_home}/${dir} ../
    fi
else
    echo ""
    echo "your version is the latest. Not pulled"
    echo ""
fi