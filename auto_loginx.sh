#!/bin/sh
 
host=$1
id=$2
pass=$3
cmd="$5"
 
expect -c "
set timeout 10
spawn ssh -XC ${host} \"$cmd\"
expect \"Are you sure you want to continue connecting (yes/no)?\" {
    send \"yes\n\"
    expect \"${id}@${host}'s password:\"
    send \"${pass}\n\"
} \"${id}@${host}'s password:\" {
    send \"${pass}\n\"
}
interact
"