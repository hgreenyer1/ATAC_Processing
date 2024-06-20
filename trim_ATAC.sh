#!/bin/bash
#SBATCH --partition=bluemoon
#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH --mem=21G
#SBATCH --time=30:00:00

#trim ATAC reads with trimGalore 

in_dir=$1
out_dir=$2

#suffixes - in
suf_f1="_1.fq.gz"
suf_f2="_2.fq.gz"

# could include min_bp here to define filtering

#loop through PE files
for f1 in $in_dir/*_1.fq.gz
do
        f2="$in_dir/$(basename -- ${f1/$suf_f1/$suf_f2})"
        
        echo "trim_galore --paired --fastqc -o $out_dir $f1 $f2"
        sbatch trim_galore --paired --fastqc -o $out_dir $f1 $f2
done
