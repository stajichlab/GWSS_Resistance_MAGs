#!/bin/bash -l
#
#SBATCH --ntasks 24 #number cores
#SBATCH --mem=98G #memory
#SBATCH -p intel,batch
#SBATCH -o logs/08_summary.log
#SBATCH -e logs/08_summary.log

SAMPFILE=samples.csv
COVDIR=coverage_anvio
CPU=16
MIN=2500
NAME=GWSS_C



module unload miniconda2
module unload anaconda3
module load miniconda3

source activate anvio-7



anvi-summarize -p ${NAME}/$NAME'_SAMPLES_MERGED'/PROFILE.db -c ${NAME}/$NAME.db -o ${NAME}/$NAME'_SAMPLES_MERGED'/sample_summary_DASTOOL -C DASTOOL

anvi-summarize -p ${NAME}/$NAME'_SAMPLES_MERGED'/PROFILE.db -c ${NAME}/$NAME.db -o ${NAME}/$NAME'_SAMPLES_MERGED'/sample_summary_METABAT -C METABAT

anvi-summarize -p ${NAME}/$NAME'_SAMPLES_MERGED'/PROFILE.db -c ${NAME}/$NAME.db -o ${NAME}/$NAME'_SAMPLES_MERGED'/sample_summary_CONCOCT -C CONCOCT

