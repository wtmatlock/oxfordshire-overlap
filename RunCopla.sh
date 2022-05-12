#!/bin/bash
#$ -S /bin/bash
#$ -N copla
#$ -j y
#$ -P bag.prjc
#$ -q short.qc -cwd -V
#$ -t 1-3705

# conda activate copla

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
mkdir ./analysis/copla

sample=$(sed -n "$SGE_TASK_ID"p ./all_plasmids/plasmid_names.txt)

copla=PATH TO bin/copla.py IN ENVIRONMENT

echo "Finished set up at: "`date`
echo "****************************************************"

echo "****************************************************"
echo "Running COPLA at: "`date`

$copla ./all_plasmids/"$sample".fasta \
	databases/Copla_RS84/RS84f_sHSBM.pickle \
	databases/Copla_RS84/CoplaDB.fofn \
	./analysis/copla/"$sample" \
	-t circular \
	-k Bacteria \
	-p Pseudomonadota \
	-c Gammaproteobacteria \
	-o Enterobacterales

echo "Finished at: "`date`
echo "*****************************************************"

echo "*****************************************************"
echo "Finished!"
echo "*****************************************************"

