#!/bin/bash
#$ -S /bin/bash
#$ -N plasmid_analysis
#$ -j y
#$ -P bag.prjc
#$ -q short.qc -cwd -V
#$ -t 1

# conda activate prokka

echo "****************************************************"
echo "SGE job ID: "$JOB_ID
echo "SGE task ID: "$SGE_TASK_ID
echo "Run on host: "`hostname`
echo "Operating system: "`uname -s`
echo "Username: "`whoami`
echo "Started at: "`date`
echo "****************************************************"

echo "****************************************************"
echo "Setting up paths and directories at: "`date`

cd /well/bag/will_sam/oxfordshire_overlap
mkdir ./analysis/{abricate,amrfinder,prokka}

sample=$(sed -n "$SGE_TASK_ID"p ./all_plasmids/plasmid_names.txt)
mkdir ./analysis/{abricate,amrfinder,prokka}/"$sample"

abricate=/well/bag/fnd111/miniconda3/prokka/bin/abricate
amrfinder=/well/bag/fnd111/miniconda3/prokka/bin/amrfinder
prokka=/well/bag/fnd111/miniconda3/prokka/bin/prokka

echo "Finished set up at: "`date`
echo "****************************************************"

echo "****************************************************"
echo "Running analysis at: "`date`

# PlasmidFinder 
# $abricate ./all_plasmids/"$sample".fasta --db plasmidfinder > ./analysis/abricate/"$sample"/"$sample"_plasmidfinder.tab
# $abricate --summary ./analysis/abricate/*/*_plasmidfinder.tab > ./analysis/abricate/plasmidfinder_summary.tab

# NCBI AMRFinderPlus
# $abricate ./all_plasmids/"$sample".fasta --db ncbi > ./analysis/abricate/"$sample"/"$sample"_plasmid_ncbi.tab
# $abricate --summary ./analysis/abricate/*/*_plasmid_ncbi.tab > ./analysis/abricate/plasmid_ncbi_summary.tab

# ISfinder
# $abricate ./all_plasmids/"$sample".fasta --db isfinder > ./analysis/abricate/"$sample"/"$sample"_plasmid_isfinder.tab
# $abricate --summary ./analysis/abricate/*/*_plasmid_isfinder.tab > ./analysis/abricate/plasmid_isfinder_summary.tab

# ICEberg
# $abricate ./all_plasmids/"$sample".fasta --db ICEberg > ./analysis/abricate/"$sample"/"$sample"_plasmid_ICEberg.tab
# $abricate --summary ./analysis/abricate/*/*_plasmid_ICEberg.tab > ./analysis/abricate/plasmid_ICEberg_summary.tab

# BacMet2
# $abricate ./all_plasmids/"$sample".fasta --db bacmet2 > ./analysis/abricate/"$sample"/"$sample"_plasmid_bacmet.tab
# $abricate --summary ./analysis/abricate/*/*_plasmid_bacmet.tab > ./analysis/abricate/plasmid_bacmet_summary.tab

# MobileElementFinder
# $abricate ./all_plasmids/"$sample".fasta --db mefinder > ./analysis/abricate/"$sample"/"$sample"_plasmid_mefinder.tab
# $abricate --summary ./analysis/abricate/*/*_plasmid_mefinder.tab > ./analysis/abricate/plasmid_mefinder_summary.tab

# Toxin-Antitoxin
# $abricate ./all_plasmids/"$sample".fasta --db toxin_antitoxin > ./analysis/abricate/"$sample"/"$sample"_plasmid_tat.tab
# $abricate --summary ./analysis/abricate/*/*_plasmid_tat.tab > ./analysis/abricate/plasmid_tat_summary.tab

# AMRFinder
# $amrfinder -n ./all_plasmids/"$sample".fasta > ./analysis/amrfinder/"$sample"/"$sample"_amrfinder.tsv

# Prokka
# $prokka ./all_plasmids/"$sample".fasta --quiet --centre X --compliant --outdir ./analysis/prokka/"$sample" --force --prefix $sample

echo "Finished at: "`date`
echo "*****************************************************"

echo "*****************************************************"
echo "Finished!"
echo "*****************************************************"

