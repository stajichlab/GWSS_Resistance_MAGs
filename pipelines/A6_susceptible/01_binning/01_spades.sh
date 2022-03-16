#!/bin/bash -l
#
#SBATCH -n 48 #number cores
#SBATCH -e logs/spades.A.log
#SBATCH -o logs/spades.A.log
#SBATCH --mem 450G #memory per node in Gb
#SBATCH -p intel,batch

module load spades/3.15.2 

IN=data


spades.py -1 $IN/FB_A6_S35_L001_R1_001.fastq.gz -2 $IN/FB_A6_S35_L001_R2_001.fastq.gz -o $IN/GWSS_A_spades/ --threads 32 -m 845
