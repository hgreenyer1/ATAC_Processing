#!/bin/bash 

#perform sorting for all files in the given directory 

wd=$1

for f in $wd/*tmp.bam
do 
	sbatch /users/h/g/hgreenye/scripts/atac_scripts/sort_bam.sh $f
done 
