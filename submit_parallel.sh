#!/bin/bash

project=$1
dir=$2
mode=$3 # job/take/del
#usercmd="$3"

path=projects/$project
#precmd="source ~/.bash_profile"
#cmd="$precmd;$usercmd"
#cmd="source ~/.bash_profile;echo $MCFM"
#cmd="source ~/.bash_profile;nohup ./xsec_mh_ppjh.sh test 200 1 &"

if [ $mode == "job" ];then
    uldir.sh $dir kek $path
#    ssh takaesu@login.cc.kek.jp "cd /home/th/takaesu/${path}/;mv ~/$dir .;cd $dir;$cmd"
#    ssh takaesu@login.cc.kek.jp "cd /home/th/takaesu/${path}/;cd $dir;$cmd"
#    ssh-kek.sh "cd /home/th/takaesu/$path/;cd $dir;$cmd"
    ssh-kek.sh
#    ssh-kek.sh "cd /home/th/takaesu/$path/$dir"
elif [ $mode == "take" ];then
    dldir.sh kek $path/$dir
#    ssh takaesu@login.cc.kek.jp "cd /home/th/takaesu/${path}/;mv ~/$dir .;cd $dir;$cmd"
#    ssh takaesu@login.cc.kek.jp "cd /home/th/takaesu/${path}/;cd $dir;$cmd"
elif [ $mode == "del" ];then
#    ssh takaesu@login.cc.kek.jp "cd /home/th/takaesu/${path}/;rm -rf $dir"
    ssh-kek.sh "cd /home/th/takaesu/$path/;rm -rf $dir"
fi