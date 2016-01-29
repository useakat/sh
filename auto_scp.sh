#!/bin/sh

host=$1
id=$2
pass=$3
mode=$4
file=$5
dir=$6
 
if [ $mode == "ul" ];then
    if [ -n "$dir" ];then
	expect -c "
     set timeout 10
     spawn scp -r $file kekcc:/home/th/takaesu/$dir/.
     expect \"Are you sure you want to continue connecting (yes/no)?\" {
         send \"yes\n\"
         expect \"${id}@${host}'s password:\"
         send \"${pass}\n\"
     } \"${id}@${host}'s password:\" {
         send \"${pass}\n\"
     } \"${id}@login.cc.kek.jp's password:\" {
         send \"${pass}\n\"
     }
     interact
     "
    else
	expect -c "
     set timeout 10
     spawn scp -r $file kekcc:/home/th/takaesu/.
     expect \"Are you sure you want to continue connecting (yes/no)?\" {
         send \"yes\n\"
         expect \"${id}@${host}'s password:\"
         send \"${pass}\n\"
     } \"${id}@${host}'s password:\" {
         send \"${pass}\n\"
     } \"${id}@login.cc.kek.jp's password:\" {
         send \"${pass}\n\"
     }
     interact
     "
    fi
elif [ $mode == "dl" ];then
    if [ -n "$dir" ];then
	expect -c "
     set timeout 10
     spawn scp -r kekcc:/home/th/takaesu/$dir/$file .
     expect \"Are you sure you want to continue connecting (yes/no)?\" {
         send \"yes\n\"
         expect \"${id}@${host}'s password:\"
         send \"${pass}\n\"
     } \"${id}@${host}'s password:\" {
         send \"${pass}\n\"
     } \"${id}@login.cc.kek.jp's password:\" {
         send \"${pass}\n\"
     }
     interact
     "
    else
	expect -c "
     set timeout 10
     spawn scp -r kekcc:/home/th/takaesu/$file .
     expect \"Are you sure you want to continue connecting (yes/no)?\" {
         send \"yes\n\"
         expect \"${id}@${host}'s password:\"
         send \"${pass}\n\"
     } \"${id}@${host}'s password:\" {
         send \"${pass}\n\"
     } \"${id}@login.cc.kek.jp's password:\" {
         send \"${pass}\n\"
     }
     interact
     "
    fi
fi