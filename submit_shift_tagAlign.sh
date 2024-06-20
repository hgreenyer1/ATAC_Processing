#!/bin/bash

#submit script to convert PE BAM to tagAlign (for shifting)

IN_DIR=$1
OUT_DIR=$2

for TAG in $IN_DIR/*.nodup.tagAlign.gz
do
        sbatch /users/h/g/hgreenye/scripts/atac_scripts/shift_tagAlign.sh $TAG $OUT_DIR
done

