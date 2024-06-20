#!/bin/bash

#SBATCH --partition=bluemoon
#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH --mem=21G
#SBATCH --time=30:00:00

#===========================
# Filter ATAC alignments based on ENCODE Specifications 
# Remove mitochondrial reads, unmapped, mate unmapped
# not primary alignment, reads failing platform 
# Only keep properly paired reads 
# Obtain name sorted BAM file 
#===========================


RAW_BAM=$1
OUT_DIR=$2

BASE_NAME="$( echo $RAW_BAM | awk -F"/" '{print $NF}' | awk -F".bam" '{print $1}')"

PREFIX="$OUT_DIR/$BASE_NAME"

RM_MITO="${PREFIX}.temp.rmMito.bam"

FILT_BAM="${PREFIX}.filt.bam"

TMP_FILT_FIXMATE_BAM="${PREFIX}.tmp.fixmate.bam"

#REMOVE MITOCHONDRIAL READS ===================

samtools view -@ 4 -h ${RAW_BAM} | grep -v chrM | samtools sort -@ 4 -O bam -o ${RM_MITO}

#RM MULTIMAPPED/LOW QUAL READS =========================

samtools view -@ 4 -F 1804 -f 2 -q 30 -u ${RM_MITO} | samtools sort -n -@ 4 -O bam -o ${FILT_BAM}

rm ${RM_MITO}

echo "finished removing mito and multimapped"

samtools fixmate -r ${FILT_BAM} ${TMP_FILT_FIXMATE_BAM}

#MARK DUPLICATES with picard ======================

TMP_FILT_BAM="${PREFIX}.filt.dupmark.bam"
DUP_FILE_QC="${PREFIX}.filt.dup.qc.txt"

java -jar /users/h/g/hgreenye/picard/build/libs/picard.jar MarkDuplicates -I ${TMP_FILT_FIXMATE_BAM} -O ${TMP_FILT_BAM} -M ${DUP_FILE_QC} -ASO queryname

rm ${FILT_BAM}
rm ${TMP_FILT_FIXMATE_BAM}

echo "marked duplicates"

#REMOVE DUPLICATES ==============================

FINAL_BAM_PREFIX="${PREFIX}.filt.nodup"
FINAL_BAM_FILE="${FINAL_BAM_PREFIX}.bam"
FINAL_BAM_INDEX_FILE="${FINAL_BAM_FILE}.bai"
FINAL_BAM_FILE_MAPSTATS="${FINAL_BAM_PREFIX}.flagstat.qc"

samtools view -@ 4 -F 1804 -f 2 -b ${TMP_FILT_BAM} | samtools sort -@ 4 -O bam -o ${FINAL_BAM_FILE}

echo "removed duplicates"

# Index Final BAM file
samtools index ${FINAL_BAM_FILE}

echo "DONE!"

