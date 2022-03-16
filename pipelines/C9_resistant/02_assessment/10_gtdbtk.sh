#!/bin/bash -l
#SBATCH --ntasks=24 # Number of cores
#SBATCH --mem=200G # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -p intel,batch
#SBATCH -o logs/10_gtbtdk.log
#SBATCH -e logs/10_gtbtdk.log


module unload miniconda2
module load miniconda3

conda activate gtdbtk-1.3.0


INPUT=/rhome/cassande/shared/projects/SharpShooter/GWSS_Wolbachia/GWSS_C/GWSS_C_SAMPLES_MERGED/sample_summary_DASTOOL/bin_fasta/

OUTPUT=${INPUT}/gtbdk_results
CPU=24
PREFIX=GWSS_C

gtdbtk classify_wf --genome_dir $INPUT --out_dir $OUTPUT -x .fa --cpus $CPU --prefix $PREFIX.gtbdk
