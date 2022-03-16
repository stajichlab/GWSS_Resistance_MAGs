#!/bin/bash -l
#
#SBATCH --ntasks 16 #number cores
#SBATCH --mem=250G #memory
#SBATCH -p intel,batch
#SBATCH -o logs/01_pangenome.log
#SBATCH -e logs/01_pangenome.log


module unload miniconda2
module unload anaconda3
module load miniconda3
module load diamond

source activate anvio-7

CPU=16

#mkdir pangenome/profiles

#fix names
anvi-script-reformat-fasta pangenome/data/Sulcia_GWSS.fasta -o pangenome/data/Sulcia_GWSS_fix.fasta -l 0 --simplify-names --seq-type NT

anvi-script-reformat-fasta pangenome/data/Baumannia_cicadellinicola_Hc.fasta -o pangenome/data/Baumannia_cicadellinicola_Hc_fix.fasta -l 0 --simplify-names --seq-type NT

anvi-script-reformat-fasta pangenome/data/Homalodisca_vitripennis_leafhopper_SRR941995.fasta -o pangenome/data/Homalodisca_vitripennis_leafhopper_SRR941995_fix.fasta -l 0 --simplify-names --seq-type NT

anvi-script-reformat-fasta pangenome/data/Homalodisca_vitripennis_leafhopper_SRR941997.fasta -o pangenome/data/Homalodisca_vitripennis_leafhopper_SRR941997_fix.fasta -l 0 --simplify-names --seq-type NT



#generate db
anvi-gen-contigs-database -f pangenome/data/Sulcia_GWSS_fix.fasta -o pangenome/profiles/Sulcia_GWSS.db

anvi-gen-contigs-database -f pangenome/data/Baumannia_cicadellinicola_Hc_fix.fasta -o pangenome/profiles/Baumannia_cicadellinicola_Hc.db

anvi-gen-contigs-database -f pangenome/data/Homalodisca_vitripennis_leafhopper_SRR941995_fix.fasta -o pangenome/profiles/Homalodisca_vitripennis_leafhopper_SRR941995.db

anvi-gen-contigs-database -f pangenome/data/Homalodisca_vitripennis_leafhopper_SRR941997_fix.fasta -o pangenome/profiles/Homalodisca_vitripennis_leafhopper_SRR941997.db



#hmms
anvi-run-hmms -c pangenome/profiles/Sulcia_GWSS.db --num-threads $CPU
anvi-run-hmms -c pangenome/profiles/Baumannia_cicadellinicola_Hc.db --num-threads $CPU
anvi-run-hmms -c pangenome/profiles/Homalodisca_vitripennis_leafhopper_SRR941995.db --num-threads $CPU
anvi-run-hmms -c pangenome/profiles/Homalodisca_vitripennis_leafhopper_SRR941997.db --num-threads $CPU


#pfams
anvi-run-pfams -c pangenome/profiles/Sulcia_GWSS.db --num-threads $CPU
anvi-run-pfams -c pangenome/profiles/Baumannia_cicadellinicola_Hc.db --num-threads $CPU 
anvi-run-pfams -c pangenome/profiles/Homalodisca_vitripennis_leafhopper_SRR941995.db --num-threads $CPU
anvi-run-pfams -c pangenome/profiles/Homalodisca_vitripennis_leafhopper_SRR941997.db --num-threads $CPU

anvi-run-pfams -c GWSS_A/GWSS_A.db --num-threads $CPU
anvi-run-pfams -c GWSS_C/GWSS_C.db --num-threads $CPU
 
#kegg
anvi-run-kegg-kofams -c pangenome/profiles/Sulcia_GWSS.db -T $CPU
anvi-run-kegg-kofams -c pangenome/profiles/Baumannia_cicadellinicola_Hc.db -T $CPU
anvi-run-kegg-kofams -c pangenome/profiles/Homalodisca_vitripennis_leafhopper_SRR941995.db -T $CPU
anvi-run-kegg-kofams -c pangenome/profiles/Homalodisca_vitripennis_leafhopper_SRR941997.db -T $CPU

anvi-run-kegg-kofams -c GWSS_A/GWSS_A.db -T $CPU
anvi-run-kegg-kofams -c GWSS_C/GWSS_C.db -T $CPU

#cog
anvi-run-ncbi-cogs -c pangenome/profiles/Sulcia_GWSS.db --sensitive --num-threads $CPU
anvi-run-ncbi-cogs -c pangenome/profiles/Baumannia_cicadellinicola_Hc.db --sensitive --num-threads $CPU
anvi-run-ncbi-cogs -c pangenome/profiles/Homalodisca_vitripennis_leafhopper_SRR941995.db --sensitive --num-threads $CPU
anvi-run-ncbi-cogs -c pangenome/profiles/Homalodisca_vitripennis_leafhopper_SRR941997.db --sensitive --num-threads $CPU

anvi-run-ncbi-cogs -c GWSS_A/GWSS_A.db --sensitive --num-threads $CPU
anvi-run-ncbi-cogs -c GWSS_C/GWSS_C.db --sensitive --num-threads $CPU




#generate genome dbs

anvi-gen-genomes-storage -e pangenome/Sulcia_external_genomes.txt --internal-genomes pangenome/Sulcia_GWSS_MAG_Pangenome_Internal.txt -o pangenome/SUL-GENOMES.db

anvi-gen-genomes-storage -e pangenome/Baumannia_external_genomes.txt --internal-genomes  pangenome/Baumannia_GWSS_MAG_Pangenome_Internal.txt -o pangenome/BAU-GENOMES.db

anvi-gen-genomes-storage -e pangenome/Wol_external_genomes.txt --internal-genomes  pangenome/Wol_GWSS_MAG_Pangenome_Internal.txt  -o pangenome/WOL-GENOMES.db



#generate pan-genomes

anvi-pan-genome -g pangenome/SUL-GENOMES.db -n SUL_pan --output-dir SUL --num-threads 16 --sensitive --enforce-hierarchical-clustering --mcl-inflation 10

anvi-pan-genome -g pangenome/BAU-GENOMES.db -n BAU_pan --output-dir BAU --num-threads 16 --sensitive --enforce-hierarchical-clustering --mcl-inflation 10

anvi-pan-genome -g pangenome/WOL-GENOMES.db -n WOL_pan --output-dir WOL --num-threads 16 --sensitive --enforce-hierarchical-clustering --mcl-inflation 10
