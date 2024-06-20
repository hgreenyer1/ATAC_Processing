#!/bin/bash

IN_DIR=$1
OUT_DIR=$2

#will need to find a way to generalize the suffixes

REP1_SUFF=$3
REP2_SUFF=$4
POOL_SUFF="_pooled_sorted.filt.nodup_peaks.narrowPeak"

for REP1_PEAKS in $IN_DIR/*$REP1_SUFF
do
        BASENAME="$(basename -- ${REP1_PEAKS/"$REP1_SUFF"/""})"
	PREFIX="$OUT_DIR/$BASENAME"
        REP2_PEAKS="$(basename -- ${REP1_PEAKS/"$REP1_SUFF"/"$REP2_SUFF"})"
        POOL_PEAKS="$(basename -- ${REP1_PEAKS/"$REP1_SUFF"/"$POOL_SUFF"})"

        sbatch /users/h/g/hgreenye/scripts/atac_scripts/run_IDR.sh $PREFIX $REP1_PEAKS $REP2_PEAKS $POOL_PEAKS
done
