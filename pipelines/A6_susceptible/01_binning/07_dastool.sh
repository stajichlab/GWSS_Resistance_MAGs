#!/bin/bash -l
#
#SBATCH --ntasks 24 #number cores
#SBATCH --mem=98G #memory
#SBATCH -p intel,batch
#SBATCH -o logs/07_dastool_A.log
#SBATCH -e logs/07_dastool_A.log

SAMPFILE=samples.csv
COVDIR=coverage_anvio_A
CPU=16
MIN=2500
NAME=GWSS_A


module unload miniconda2
module unload anaconda3
module load miniconda3
#module load concoct/1.1.0
#module load metabat/0.32.4
#module load maxbin/2.2.1 

module load diamond

source activate anvio-7
#made sure to install dastool via conda to anvio-7 env

anvi-cluster-contigs -p ${NAME}/$NAME'_SAMPLES_MERGED'/PROFILE.db -c ${NAME}/$NAME.db  -C DASTOOL --driver dastool -S CONCOCT,METABAT -T $CPU --search-engine diamond --just-do-it
