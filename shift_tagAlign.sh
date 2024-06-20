#!/bin/bash

#SBATCH --partition=bluemoon
#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH --mem=21G
#SBATCH --time=30:00:00


TAG_ALIGN=$1

OUT_DIR=$2

BASE_NAME="$( echo $TAG_ALIGN | awk -F"/" '{print $NF}' | awk -F".tagAlign.gz" '{print $1}')"

PREFIX="$OUT_DIR/$BASE_NAME"

SHIFT_TAG="$PREFIX.tn5.tagAlign.gz"

zcat $TAG_ALIGN | awk -F $'\t' 'BEGIN {OFS = FS}{ if ($6 == "+") {$2 = $2 + 4} else if ($6 == "-") {$3 = $3 - 5} print $0}' | gzip -nc > $SHIFT_TAG

