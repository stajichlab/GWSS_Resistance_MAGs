#!/bin/bash -l
#
#SBATCH --ntasks 24 #number cores
#SBATCH -p intel,batch
#SBATCH -o logs/03_kaiju.log
#SBATCH -e logs/03_kaiju.log
#SBATCH --mem=48G #memory


ASSEM=data/GWSS_C_spades/scaffolds.fasta
PREFIX=GWSS_C
LOCATION=data

DB=/rhome/cassande/bigdata/software/databases/kaiju
CPU=24
SAMPFILE=samples.csv
COVDIR=coverage


module load kaiju
module unload miniconda2
module unload anaconda3

module load miniconda3

source activate anvio-7


kaiju -z $CPU -t $DB/nodes.dmp -f $DB/kaiju_db_nr_euk.fmi -i  ${PREFIX}/$PREFIX.gene.calls.fa -o ${PREFIX}/$PREFIX.kaiju.out -v

kaiju-addTaxonNames -t $DB/nodes.dmp -n $DB/names.dmp -i ${PREFIX}/$PREFIX.kaiju.out -o ${PREFIX}/$PREFIX.kaiju.names.out -r superkingdom,phylum,class,order,family,genus,species

anvi-import-taxonomy-for-genes -i ${PREFIX}/$PREFIX.kaiju.names.out -c ${PREFIX}/$PREFIX.db -p kaiju --just-do-it
	



