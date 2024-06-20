#!/bin/bash 
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8

#script for shifting ATAC reads before peak calling 

in_bam=$1
tmp_bam=$2

#ATACshift 
alignmentSieve --numberOfProcessors 8  --ATACshift --bam $in_bam -o $tmp_bam

