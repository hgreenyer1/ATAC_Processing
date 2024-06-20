#!/bin/bash 

REP1_TAG=$1
REP2_TAG=$2
POOL_TAG=$3


zcat ${REP1_TAG} ${REP2_TAG} | gzip -nc > ${POOL_TAG}
