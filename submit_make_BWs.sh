#!/bin/bash 

#=========
#generate FE bigwigs for all peaks in a given directory
#==========

IN_DIR=$1
OUT_DIR=$2

for PEAKS in $IN_DIR/*peaks.narrowPeak
do
	PREFIX=$(basename $PEAKS $SUFF)
        sbatch /users/h/g/hgreenye/scripts/atac_scripts/run_make_BWs.sh $PREFIX $IN_DIR $OUT_DIR
done
