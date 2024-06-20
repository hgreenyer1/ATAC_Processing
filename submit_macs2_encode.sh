#!/bin/bash

IN_DIR=$1
OUT_DIR=$2
SUFF=$3


for TAG in $IN_DIR/*$SUFF
do
        sbatch /gpfs1/home/h/g/hgreenye/scripts/atac_scripts/run_macs2_encode.sh $TAG $OUT_DIR
done

