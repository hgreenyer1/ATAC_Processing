#!/bin/bash

#SBATCH --partition=bluemoon
#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH --mem=21G
#SBATCH --time=30:00:00


FINAL_NMSRT_BAM_FILE=$1

OUT_DIR=$2

BASE_NAME="$( echo $FINAL_NMSRT_BAM_FILE | awk -F"/" '{print $NF}' | awk -F".bam" '{print $1}')"

FINAL_NMSRT_BAM_PREFIX="$OUT_DIR/$BASE_NAME"


FINAL_BEDPE_FILE="${FINAL_NMSRT_BAM_PREFIX}.bedpe.gz"
FINAL_TA_FILE="${FINAL_NMSRT_BAM_PREFIX}.tagAlign.gz"

bedtools bamtobed -bedpe -mate1 -i ${FINAL_NMSRT_BAM_FILE} | gzip -nc > ${FINAL_BEDPE_FILE}

# Create final TA file
zcat ${FINAL_BEDPE_FILE} | awk 'BEGIN{OFS="\t"}{printf "%s\t%s\t%s\tN\t1000\t%s\n%s\t%s\t%s\tN\t1000\t%s\n",$1,$2,$3,$9,$4,$5,$6,$10}' | gzip -nc > ${FINAL_TA_FILE}

