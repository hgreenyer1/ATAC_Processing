#!/bin/bash
#pool triplicate reps 

REP1_TAG=$1
REP2_TAG=$2
REP3_TAG=$3

POOL_TAG=$4


zcat ${REP1_TAG} ${REP2_TAG} ${REP3_TAG} | gzip -nc > ${POOL_TAG}
