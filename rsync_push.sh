#!/bin/bash
if [[ "$1" == "-h" ]]; then
    echo ""
    echo "Usage: rsync_push.sh"
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
    echo ""
    echo "ERROR:This platform is not supported."
    echo ""
fi
if [ $ikekcc -eq 1 ];then
    dir=${path##${rmpath1}/}
    dir=${dir##${rmpath2}/}
else
    dir=${path##${rmpath}/}
fi

echo `date '+%s'` > date.txt

if [ -e .exclude_list ];then
    rsync -avzr --delete --exclude-from '.exclude_list' -e ssh ./ useakat@133.242.151.135:/home/useakat/${dir}
else
#rsync -avzr --delete -e ssh ./ yoshitar@heget.kek.jp:/home/yoshitar/${dir}
    rsync -avzr --delete -e ssh ./ useakat@133.242.151.135:/home/useakat/${dir}
fi