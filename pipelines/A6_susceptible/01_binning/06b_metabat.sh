#!/bin/bash -l
#
#SBATCH --ntasks 24 #number cores
#SBATCH --mem=98G #memory
#SBATCH -p intel,batch
#SBATCH -o logs/06b_metabat_A.log
#SBATCH -e logs/06b_metabat_A.log

SAMPFILE=samples.csv
COVDIR=coverage_anvio_A
CPU=16
MIN=2500
NAME=GWSS_A

module unload miniconda2
module unload anaconda3
module load miniconda3

source activate anvio-7
#installed metabat2 to anvio env


anvi-cluster-contigs -p ${NAME}/$NAME'_SAMPLES_MERGED'/PROFILE.db -c ${NAME}/$NAME.db -C METABAT --driver metabat2 -T $CPU --just-do-it
	
