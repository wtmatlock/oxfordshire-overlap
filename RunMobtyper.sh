#!/bin/bash
#$ -S /bin/bash
#$ -N mob-typer
#$ -e amr.err
#$ -j y
#$ -P bag.prjc
#$ -q short.qc -cwd -V
#$ -t 1-3706

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
mkdir ./analysis/mob-typer

sample=$(sed -n "$SGE_TASK_ID"p ./all_plasmids/plasmid_names.txt)
mkdir ./analysis/mob-typer/"$sample"

#mobtyper=/well/bag/users/lipworth/miniconda3/bin/mob_typer

echo "Finished set up at: "`date`
echo "****************************************************"

echo "****************************************************"
echo "Running analysis at: "`date`

# MOB-typer 
mob_typer --infile ./all_plasmids/"$sample".fasta --out_file .analysis/mob-typer/"$sample"/"$sample"_mobtyper.txt

echo "Finished at: "`date`
echo "*****************************************************"

echo "*****************************************************"
echo "Finished!"
echo "*****************************************************"

