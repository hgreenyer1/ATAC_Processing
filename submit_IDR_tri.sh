#!/bin/bash

IN_DIR=$1
OUT_DIR=$2

REP_SUFF=$3
POOL_SUFF="pooled_sorted.filt.nodup_peaks.narrowPeak"

for REP1_PEAKS in $IN_DIR/*"R1_$REP_SUFF"
do
        BASENAME="$(basename -- ${REP1_PEAKS/"$REP1_SUFF"/""})"
        PREFIX="$OUT_DIR/$BASENAME"
        REP2_PEAKS="$(basename -- ${REP1_PEAKS/"R1_$REP_SUFF"/"R2_$REP_SUFF"})"
	REP3_PEAKS="$(basename -- ${REP1_PEAKS/"R1_$REP_SUFF"/"R3_$REP_SUFF"})"
        POOL_PEAKS="$(basename -- ${REP1_PEAKS/"R1_$REP_SUFF"/"$POOL_SUFF"})"

        sbatch /users/h/g/hgreenye/scripts/atac_scripts/run_IDR_tri.sh $PREFIX $REP1_PEAKS $REP2_PEAKS $REP3_PEAKS $POOL_PEAKS
done

