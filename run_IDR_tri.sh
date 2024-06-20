#!/bin/bash

#SBATCH --partition=bluemoon
#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH --mem=21G
#SBATCH --time=30:00:00

PREFIX=$1
REP1_PEAK_FILE=$2
REP2_PEAK_FILE=$3
REP3_PEAK_FILE=$4
POOLED_PEAK_FILE=$5


IDR_THRESH=0.05
IDR_OUTPUT="${PREFIX}_overlapped-peaks.txt"

idr --samples ${REP1_PEAK_FILE} ${REP2_PEAK_FILE} ${REP3_PEAK_FILE} --peak-list ${POOLED_PEAK_FILE} --input-file-type narrowPeak --output-file ${IDR_OUTPUT} --rank p.value --plot --use-best-multisummit-IDR

# =============================
# Get peaks passing IDR threshold of 5%
# =============================
IDR_THRESH_TRANSFORMED=$(awk -v p=${IDR_THRESH} 'BEGIN{print -log(p)/log(10)}')

awk 'BEGIN{OFS="\t"} $12>='"${IDR_THRESH_TRANSFORMED}"' {print $1,$2,$3,$4,$5,$6,$7,$8,$9,$10}' ${IDR_OUTPUT} | sort | uniq | sort -k7n,7n | gzip -nc > ${PREFIX}.IDR0.05.narrowPeak.gz





