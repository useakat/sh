#!/bin/bash
if [[ "$1" == "-h" ]]; then
    echo ""
    echo "Usage: "
    echo ""
    exit
fi
selfdir=$(cd $(dirname $0);pwd)
if [[ $1 = "h" ]]; then
    echo "eps file"
    read eps
#    echo "pdf file"
#    read pdf
else
    if [ $# -ge 1 ];then
	eps=$1
#    elif [ $# -ge 2 ];then
#	pdf=$1
    fi
fi
pdf=${eps%.eps}.pdf

ps2pdf $eps
pdfcrop --margins 5 $pdf $pdf 
    
