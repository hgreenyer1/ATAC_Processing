#!/bin/bash

#filter all bams in given directory based on encode specifications 

in_dir=$1
out_dir=$2

for f in $in_dir/*sorted.bam
do
        sbatch /users/h/g/hgreenye/scripts/atac_scripts/filter_bams_encode.sh $f $out_dir
done

