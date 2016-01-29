#!/bin/bash
if [[ "$1" == "-h" ]]; then
    echo ""
    echo "Usage: rsync_rm.sh (dir)"
    echo ""
    echo " (dir) directory to be deleted at remote and local."
    echo "If not specified, the current directory is deleted"
    exit
fi

#set the parameters
rmpath=$STUDY
host=useakat@133.242.151.135

#get the directory path
if [ $# -gt 0 ]; then
    dir=$1
    if [ -e $dir ]; then
	cd $dir
    else
	echo "The directory does not exist! Stopping..."
    fi
else
    path=`pwd`    
    dir=`basename $path`
fi

#Confirmation of deleting the directory
echo "Both the remote and local $dir will be deleted. OK?: yes[y] or no[n]?"
read ans
if [ $ans == "y" ];then
    #delete the directory at remote
    path=`pwd`
    dirpath1=${path##${rmpath}/}
    dirpath=${dirpath1%/${dir}}
    ssh $host "cd /home/useakat/${dirpath}/;rm -rf $dir"
    echo "deleted the directory at remote"
    #delte the directory at local
    cd ..
    rm -rf $dir
    echo "deleted the directory here"
else
    echo "The derectory is not deleted. Exiting..."
fi



    