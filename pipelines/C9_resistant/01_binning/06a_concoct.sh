#!/bin/bash -l
#
#SBATCH --ntasks 24 #number cores
#SBATCH --mem=98G #memory
#SBATCH -p intel,batch
#SBATCH -o logs/06a_concoct.log
#SBATCH -e logs/06a_concoct.log


SAMPFILE=samples.csv
COVDIR=coverage_anvio
CPU=16
MIN=2500
NAME=GWSS_C


module unload miniconda2
module unload anaconda3
module load miniconda3


source activate anvio-7
#must also install concoct to conda anvio env



anvi-cluster-contigs -p ${NAME}/$NAME'_SAMPLES_MERGED'/PROFILE.db -c ${NAME}/$NAME.db -C CONCOCT --driver concoct -T $CPU --just-do-it
	
