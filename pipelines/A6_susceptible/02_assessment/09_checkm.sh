#!/bin/bash -l
#
#SBATCH -n 24 #number cores
#SBATCH -p intel,batch
#SBATCH -o logs/09_checkm_A.log
#SBATCH -e logs/09_checkm_A.log
#SBATCH --mem 96G #memory in Gb
#SBATCH -t 96:00:00 #time in hours:min:sec


module load checkm

BINFOLDER=/rhome/cassande/shared/projects/SharpShooter/GWSS_Wolbachia/GWSS_A/GWSS_A_SAMPLES_MERGED/sample_summary_DASTOOL/bin_fasta/
OUTPUT=dastool_checkM
CPU=24

checkm lineage_wf -t $CPU -x fa $BINFOLDER $OUTPUT

checkm tree $BINFOLDER -x .fa -t $CPU $OUTPUT/tree

checkm tree_qa $OUTPUT/tree -f $OUTPUT/$OUTPUT.checkm.txt
