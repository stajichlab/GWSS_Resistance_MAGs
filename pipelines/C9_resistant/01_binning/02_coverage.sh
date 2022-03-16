#!/bin/bash -l
#
#SBATCH --ntasks 24 #number cores
#SBATCH -o logs/01_cov.log
#SBATCH -e logs/01_cov.log
#SBATCH --mem=98G #memory
#SBATCH -p intel,batch

module unload miniconda2
module unload anaconda3

module load miniconda3

source activate anvio-7

COVDIR=coverage_anvio
CPU=24

mkdir $COVDIR

ASSEM=data/GWSS_C_spades/scaffolds.fasta
PREFIX=GWSS_C
LOCATION=data
CREAD=FB_C9_S36
AREAD=FB_A6_S35


anvi-script-reformat-fasta $ASSEM -o $LOCATION/scaffolds.fixed.fa -l 0 --simplify-names

bowtie2-build $LOCATION/scaffolds.fixed.fa ${COVDIR}/$PREFIX

bowtie2 --threads $CPU -x  ${COVDIR}/$PREFIX -1 ${LOCATION}/$CREAD'_L001_R1_001.fastq.gz' -2 ${LOCATION}/$CREAD'_L001_R2_001.fastq.gz' -S ${COVDIR}/$CREAD'.sam'
samtools view -F 4 -bS ${COVDIR}/$CREAD'.sam' > ${COVDIR}/$CREAD'-RAW.bam'
anvi-init-bam ${COVDIR}/$CREAD'-RAW.bam' -o ${COVDIR}/$CREAD'.bam'

bowtie2 --threads $CPU -x  ${COVDIR}/$PREFIX -1 ${LOCATION}/$AREAD'_L001_R1_001.fastq.gz' -2 ${LOCATION}/$AREAD'_L001_R2_001.fastq.gz' -S ${COVDIR}/$AREAD'.sam'
samtools view -F 4 -bS ${COVDIR}/$AREAD'.sam' > ${COVDIR}/$AREAD'-RAW.bam'
anvi-init-bam ${COVDIR}/$AREAD'-RAW.bam' -o ${COVDIR}/$AREAD'.bam'

mkdir $PREFIX

anvi-gen-contigs-database -f ${LOCATION}/scaffolds.fixed.fa -o ${PREFIX}/$PREFIX.db
anvi-run-hmms -c ${PREFIX}/$PREFIX.db --num-threads $CPU
anvi-get-sequences-for-gene-calls -c ${PREFIX}/$PREFIX.db -o ${PREFIX}/$PREFIX.gene.calls.fa
anvi-get-sequences-for-gene-calls -c ${PREFIX}/$PREFIX.db --get-aa-sequences -o ${PREFIX}/$PREFIX.amino.acid.sequences.fa

