#!/bin/bash
if [[ "$1" == "-h" ]]; then
    echo ""
    echo "Usage: dldir.sh [host] [path/folder]"
    echo ""
    echo " [host] name of the host server with the login name"
    echo ""
    echo " [path/folder] Path to the folder to be downloaded from the home directory of the host"
    exit
fi

host=$1
pathfolder=$2

rmpath=$STUDY
#path=`pwd`
#dir=${path##${rmpath}/}
folder=${pathfolder##*/}
path=${pathfolder%/*}
file=${folder}.tar

if [[ $host == "heg" ]]; then
    ssh yoshitar@heget.kek.jp "cd /home/yoshitar/${path}/;tar zcvf $file $folder"
    scp -r yoshitar@heget.kek.jp:/home/yoshitar/${path}/$file .
    ssh yoshitar@heget.kek.jp "cd /home/yoshitar/${path}/;rm -rf $file"
elif [[ $host == "kek" ]]; then
#    ssh takaesu@login.cc.kek.jp "cd /home/th/takaesu/${path}/;tar zcvf $file $folder"
#    scp -r takaesu@login.cc.kek.jp:/home/th/takaesu/${path}/$file .
#    ssh takaesu@login.cc.kek.jp "cd /home/th/takaesu/${path}/;rm -rf $file"
    ssh-kek.sh "cd /home/th/takaesu/${path}/;tar zcvf $file $folder"
    auto_scp.sh kekcc takaesu hE12517@1422 dl $file $path
#    ssh-kek.sh "cd /home/th/takaesu/${path}/;rm -rf $file"
elif [[ $host == "ing" ]]; then
    ssh takaesu@ingrid-ui1.cism.ucl.ac.be "cd /home/fynu/takaesu/${path}/;tar zcvf $file $folder"
    scp -r takaesu@ingrid-ui1.cism.ucl.ac.be:/home/fynu/takaesu/${path}/$file .
    ssh takaesu@ingrid-ui1.cism.ucl.ac.be "cd /home/fynu/takaesu/${path}/;rm -rf $file"
elif [[ $host == "ucl" ]]; then
    ssh ytakaesu@server02.fynu.ucl.ac.be "cd /home/ytakaesu/${path}/;tar zcvf $file $folder"
    scp -r ytakaesu@server02.fynu.ucl.ac.be:/home/ytakaesu/${path}/$file .
    ssh ytakaesu@server02.fynu.ucl.ac.be "cd /home/ytakaesu/${path}/;rm -rf $file"
elif [[ $host == "sak" ]]; then
    ssh useakat@133.242.151.135 "cd /home/useakat/${path}/;tar zcvf $file $folder"
    scp -r useakat@133.242.151.135:/home/useakat/${path}/$file .
    ssh useakat@133.242.151.135 "cd /home/useakat/${path}/;rm -rf $file"
fi

tar zxvf $file
rm $file