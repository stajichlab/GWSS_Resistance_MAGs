#!/bin/bash -l
#
#SBATCH --ntasks 16 #number cores
#SBATCH --mem=250G #memory
#SBATCH -p intel,batch
#SBATCH -o logs/02_ani.log
#SBATCH -e logs/02_ani.log


module unload miniconda2
module unload anaconda3
module load miniconda3
module load diamond

source activate anvio-7

CPU=16


anvi-compute-genome-similarity --external-genomes pangenome/Sulcia_external_genomes.txt --internal-genomes pangenome/Sulcia_GWSS_MAG_Pangenome_Internal.txt --program pyANI --output-dir pangenome/SUL_ANI --num-threads 6 --pan-db pangenome/SUL/SUL_pan-PAN.db
 
anvi-compute-genome-similarity --external-genomes pangenome/Baumannia_external_genomes.txt --internal-genomes pangenome/Baumannia_GWSS_MAG_Pangenome_Internal.txt --program pyANI --output-dir pangenome/BAU_ANI --num-threads 6 --pan-db pangenome/BAU/BAU_pan-PAN.db
 
anvi-compute-genome-similarity --external-genomes pangenome/Wol_external_genomes.txt --internal-genomes pangenome/Wol_GWSS_MAG_Pangenome_Internal.txt --program pyANI --output-dir pangenome/WOL_ANI --num-threads 6 --pan-db pangenome/WOL/WOL_pan-PAN.db
 
