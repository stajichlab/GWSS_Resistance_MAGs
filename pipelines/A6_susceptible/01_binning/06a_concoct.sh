#!/bin/bash -l
#
#SBATCH --ntasks 24 #number cores
#SBATCH --mem=98G #memory
#SBATCH -p intel,batch
#SBATCH -o logs/06a_concoct_A.log
#SBATCH -e logs/06a_concoct_A.log

SAMPFILE=samples.csv
COVDIR=coverage_anvio_A
CPU=16
MIN=2500
NAME=GWSS_A


module unload miniconda2
module unload anaconda3
module load miniconda3
module load concoct/1.1.0


source activate anvio-7



anvi-cluster-contigs -p ${NAME}/$NAME'_SAMPLES_MERGED'/PROFILE.db -c ${NAME}/$NAME.db -C CONCOCT --driver concoct -T $CPU --just-do-it
	
