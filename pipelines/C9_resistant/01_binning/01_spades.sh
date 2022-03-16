#!/bin/bash -l
#
#SBATCH -n 32 #number cores
#SBATCH -e logs/spades.C.log
#SBATCH -o logs/spades.C.log
#SBATCH --mem 650G #memory per node in Gb
#SBATCH -p highmem

module load spades/3.15.2 

IN=data


spades.py -1 $IN/FB_C9_S36_L001_R1_001.fastq.gz -2 $IN/FB_C9_S36_L001_R2_001.fastq.gz -o $IN/GWSS_C_spades/ --threads 32 -m 645
