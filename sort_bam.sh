#!/bin/bash 

#sorts bam files 
#required before merging bam files 

f=$1
suf_in="tmp.bam"
suf_out="shifted.bam"

f_out="$(basename -- ${f/$suf_in/$suf_out})"

samtools sort -o $f_out
