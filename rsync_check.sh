#!/bin/bash
if [[ "$1" == "-h" ]]; then
    echo ""
    echo "Usage: rsync_check.sh"
    echo ""
    exit
fi

# server=yoshitar@heget.kek.jp
# server_home=/home/yoshitar
server=useakat@133.242.151.135
server_home=/home/useakat

ikekcc=0
path=`pwd`
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
    echo "ERROR:This platform is not supported."
fi
if [ $ikekcc -eq 1 ];then
    dir=${path##${rmpath1}/}
    dir=${dir##${rmpath2}/}
else
    dir=${path##${rmpath}/}
fi
dir2=${path##*/}

ssh ${server} cat ${dir}/date.txt > date_server.txt
read local_date < date.txt
read server_date < date_server.txt
if [ ${local_date} -lt ${server_date} ];then
    echo "Updates on the server. Pull?: [y/n]"
    read ans
    if [ $ans = "y" ];then
	cd ..
	rm -rf ${dir2}_bk
	cp -rf $dir2 ${dir2}_bk
	cd $dir2
	ssh ${server} cat ${dir}/date.txt > date_server.txt
	if [ -e .exclude_list ];then
	    rsync -avzr --delete --exclude-from '.exclude_list' -e ssh ${server}:${server_home}/${dir} ../
	else
	    rsync -avzr --delete -e ssh ${server}:${server_home}/${dir} ../
	fi
    else
	i=1
    fi
elif [ ${local_date} -ge ${server_date} ];then
    echo "Your version is the latest. Push?: [y/n]"
    read ans
    if [ $ans = "y" ];then
	echo `date '+%s'` > date.txt
	if [ -e .exclude_list ];then
	    rsync -avzr --delete --exclude-from '.exclude_list' -e ssh ./ useakat@133.242.151.135:/home/useakat/${dir}
	else
	    rsync -avzr --delete -e ssh ./ useakat@133.242.151.135:/home/useakat/${dir}
	fi
    else
	i=1
    fi
else
    echo "Error: cannot compare the time stamps."
fi