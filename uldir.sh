#!/bin/bash
if [[ "$1" == "-h" ]]; then
    echo ""
    echo "Usage: uldir.sh [dir] [host] [host_dir]"
    echo ""
    echo " [folder] folder to be uploaded"
    echo " [host] name of the host server with the login name"
    echo " [host_dir] directory the file to be uploaded. home=~/"
    echo ""
    exit
fi

folder=$1
host=$2
if [ $# -ge 3 ];then
    host_dir=$3
else
    rmpath=$STUDY
    rmpathd=Study_D
    path=`pwd`
    dir1=${path##${rmpath}/}
    host_dir=${dir1##*${rmpathd}/}
fi

file=${folder}.tar
tar zcvf $file $folder

if [[ $host == "heg" ]]; then
    if [ $host_dir = "home" ];then
	scp -r $file yoshitar@heget.kek.jp:/home/yoshitar/.
    else
	scp -r $file yoshitar@heget.kek.jp:/home/yoshitar/${host_dir}/.
    fi
    ssh yoshitar@heget.kek.jp "cd /home/yoshitar/${host_dir}/;tar zxvf $file;rm -rf $file"
elif [[ $host == "kek" ]]; then
    if [ $host_dir = "home" ];then
#	scp -r $file takaesu@login.cc.kek.jp:/home/th/takaesu/.
	auto_scp.sh kekcc takaesu hE12517@1422 ul $file
	auto_login.sh kekcc takaesu hE12517@1422 "cd /home/th/takaesu/;tar zxvf $file;rm -rf $file"
    else
#	scp -r $file takaesu@login.cc.kek.jp:/home/th/takaesu/${host_dir}/.
	auto_scp.sh kekcc takaesu hE12517@1422 ul $file $host_dir
	auto_login.sh kekcc takaesu hE12517@1422 "cd /home/th/takaesu/$host_dir/;tar zxvf $file;rm -rf $file"
    fi
#    ssh takaesu@login.cc.kek.jp "cd /home/th/takaesu/${host_dir}/;tar zxvf $file;rm -rf $file"
elif [[ $host == "ing" ]]; then
    if [ $host_dir = "home" ];then
	scp -r $file takaesu@ingrid-ui1.cism.ucl.ac.be:/home/fynu/takaesu/.
    else
	scp -r $file takaesu@ingrid-ui1.cism.ucl.ac.be:/home/fynu/takaesu/${host_dir}/.
    fi
    ssh takaesu@ingrid-ui1.cism.ucl.ac.be "cd /home/fynu/takaesu/${host_dir}/;tar zxvf $file;rm -rf $file"
elif [[ $host == "ucl" ]]; then
    if [ $host_dir = "home" ];then
	scp -r $file ytakaesu@server02.fynu.ucl.ac.be:/home/ytakaesu/.
    else
	scp -r $file ytakaesu@server02.fynu.ucl.ac.be:/home/ytakaesu/${host_dir}/.
    fi
    ssh ytakaesu@server02.fynu.ucl.ac.be "cd /home/ytakaesu/${host_dir}/;tar zxvf $file;rm -rf $file"
elif [[ $host == "sakura" ]]; then
    if [ $host_dir = "home" ];then
	scp -r $file useakat@133.242.151.135:/home/useakat/.
    else
	scp -r $file useakat@133.242.151.135:/home/useakat/${host_dir}/.
    fi
    ssh useakat@133.242.151.135 "cd /home/useakat/${host_dir}/;tar zxvf $file;rm -rf $file"
fi

rm $file