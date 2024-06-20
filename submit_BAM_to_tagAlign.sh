#!/bin/bash

#submit script to convert PE BAM to tagAlign (for shifting)

IN_DIR=$1
OUT_DIR=$2

#I need to set this up to generalize the suffix

for BAM in $IN_DIR/*.mLb.clN.sorted.bam
do
        echo "/users/h/g/hgreenye/scripts/atac_scripts/BAM_to_tagAlign.sh $BAM $OUT_DIR"
	sbatch /users/h/g/hgreenye/scripts/atac_scripts/BAM_to_tagAlign.sh $BAM $OUT_DIR
done


