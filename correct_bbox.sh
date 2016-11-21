#!/bin/sh                                                                       
for FILE in *eps
do
    IN=${FILE%.eps}
    ps2pdf -dEPSCrop -dPDFSETTINGS=/prepress $IN.eps $IN.pdf
    pdf2ps $IN.pdf $IN.eps
    rm $IN.pdf
done