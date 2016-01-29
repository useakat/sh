#!/bin/bash

echo "data?"
read data
echo "figure?"
read fig
echo "title?"
read title
echo "xlabel?"
read xlabel
echo "ylabel?"
read ylabel
echo "gnu?"
read gnu

if [ -n "$gnu" ];then
    gnu=$gnu.gnu
else
    gnu=plot.gnu
fi
echo "###################### Options ###########################################" > $gnu
echo "#set logscale x" >> $gnu
echo "#set logscale y" >> $gnu
echo "#set format x '%L'" >> $gnu
echo "#set format y '10^{%L}'" >> $gnu
echo "#set xtics (2,3,4,5,6)" >> $gnu
echo "#set ytics (1,10,1E2,1E3,1E4,1E5,1E6,1E7,1E8,1E9,1E10)" >> $gnu
echo "#set tics scale 2" >> $gnu
echo "#set key at 1.0E3,1.0E7 samplen 2" >> $gnu
echo "#set xrange [1:7]" >> $gnu
echo "#set yrange [1E-5:2E8]" >> $gnu
echo "####################### Definitions ######################################" >> $gnu
echo "file1 = '$data.dat'" >> $gnu
echo "c1 = 'red'" >> $gnu
echo "c2 = 'blue'" >> $gnu
echo "c3 = '#006400' # dark green" >> $gnu
echo "c4 = 'purple'" >> $gnu
echo "c5 = '#ff33ff'" >> $gnu
echo "c6 = '#cc6600' # dark orange" >> $gnu
echo "##########################################################################" >> $gnu
echo "set terminal postscript eps enhanced 'Times-Roman' color 20" >> $gnu
echo "set output '$fig.eps'" >> $gnu
echo "set grid" >> $gnu
echo "set key spacing 1.5 samplen 2" >> $gnu
echo "#set multiplot" >> $gnu
echo " " >> $gnu
if [ -n "$title" ];then
    echo "set title '{/=28 $title}'" >> $gnu
fi
if [ -n "$xlabel" ];then
    echo "set xlabel '{/=24 $xlabel}'" >> $gnu
fi
if [ -n "$ylabel" ];then
    echo "set ylabel '{/=24 $ylabel}' offset 1.5,0" >> $gnu
fi
echo "#################### plot ##########################################" >> $gnu
echo "plot \ " >> $gnu
echo "file1 u 1:2 title 'CCQE H' w l lt 1 lw 3 lc rgb c1" >> $gnu
echo "###########################################################################" >> $gnu
echo "#set nomultiplot" >> $gnu
echo "reset" >> $gnu

gnuplot $gnu