#!/bin/bash -l
#
#SBATCH --ntasks 16 #number cores
#SBATCH --mem=250G #memory
#SBATCH -p intel,batch
#SBATCH -o logs/05_merge.log
#SBATCH -e logs/05_merge.log

SAMPFILE=samples.csv
COVDIR=coverage_anvio
CPU=16
MIN=2500



ASSEM=data/GWSS_C_spades/scaffolds.fasta
NAME=GWSS_C
LOCATION=data
CREAD=FB_C9_S36
AREAD=FB_A6_S35



module unload miniconda2
module unload anaconda3
module load miniconda3

source activate anvio-7



anvi-merge ${NAME}/*profile/PROFILE.db -o ${NAME}/$NAME'_SAMPLES_MERGED' -c ${NAME}/$NAME.db --enforce-hierarchical-clustering
	
