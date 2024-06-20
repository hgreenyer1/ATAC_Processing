#!/bin/bash

IN_DIR=$1
REPS=$2
SUFF=$3

#POOL_SUFF=$'pooled_sorted.filt.nodup.tagAlign.gz'
POOL_SUFF=$'.mRp.clN.sorted.bam'

if [[ "${REPS}" == "duplicate" ]]; then

	for REP1_TAG in $IN_DIR/*"R1_${SUFF}"
	do
        	REP2_TAG="$(basename -- ${REP1_TAG/"R1_${SUFF}"/"R2_${SUFF}"})"
        	POOL_TAG="$(basename -- ${REP1_TAG/"R1_${SUFF}"/"$POOL_SUFF"})"

        	sbatch /users/h/g/hgreenye/scripts/atac_scripts/run_pool_tagAlign.sh $REP1_TAG $REP2_TAG $POOL_TAG
	done

elif [[ "${REPS}" == "triplicate" ]]; then

	for REP1_TAG in $IN_DIR/*"R1_${SUFF}"
	do
        	REP2_TAG="${IN_DIR}/$(basename -- ${REP1_TAG/"R1_${SUFF}"/"R2_${SUFF}"})"
		REP3_TAG="${IN_DIR}/$(basename -- ${REP1_TAG/"R1_${SUFF}"/"R3_${SUFF}"})"
        	POOL_TAG="${IN_DIR}/$(basename -- ${REP1_TAG/"R1_${SUFF}"/"$POOL_SUFF"})"

        	sbatch /users/h/g/hgreenye/scripts/atac_scripts/run_pool_tagAlign_tri.sh $REP1_TAG $REP2_TAG $REP3_TAG $POOL_TAG
	done
fi

