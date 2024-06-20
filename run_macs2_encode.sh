#!/bin/bash 

#SBATCH --partition=bluemoon
#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH --mem=21G
#SBATCH --time=30:00:00

TAG=$1
OUT_DIR=$2
PVAL=".01"
SMOOTH_WIN=150
SHIFTSIZE=$(( -$SMOOTH_WIN/2 ))

PREFIX="$(basename -- ${TAG/".tagAlign.gz"/""})"

# call narrowPeaks

macs2 callpeak -t $TAG -f BED -g "hs" --outdir $OUT_DIR -n $PREFIX -p $PVAL --shift $SHIFTSIZE --extsize $SMOOTH_WIN -B --SPMR --keep-dup all --nomodel --bdg


