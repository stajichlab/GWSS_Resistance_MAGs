#!/bin/bash -l
#
#SBATCH --ntasks 16 #number cores
#SBATCH --mem=250G #memory
#SBATCH -p intel,batch
#SBATCH -o logs/04_prof_A.log
#SBATCH -e logs/04_prof_A.log

SAMPFILE=samples.csv
COVDIR=coverage_anvio_A
CPU=16
MIN=2500


ASSEM=data/GWSS_A_spades/scaffolds.fasta
NAME=GWSS_A
LOCATION=data
CREAD=FB_C9_S36
AREAD=FB_A6_S35


module unload miniconda2
module unload anaconda3
module load miniconda3

source activate anvio-7

anvi-profile -i ${COVDIR}/$CREAD'.bam' -c ${NAME}/$NAME.db --num-threads $CPU --min-contig-length $MIN --cluster-contigs --output-dir ${NAME}/$CREAD'_profile'
anvi-profile -i ${COVDIR}/$AREAD'.bam' -c ${NAME}/$NAME.db --num-threads $CPU --min-contig-length $MIN --cluster-contigs --output-dir ${NAME}/$AREAD'_profile'
	

