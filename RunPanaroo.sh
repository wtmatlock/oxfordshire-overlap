#!/bin/bash
#$ -S /bin/bash
#$ -N panaroo
#$ -j y
#$ -P bag.prjc
#$ -q short.qc -cwd -V
#$ -t 2

echo "****************************************************"
echo "SGE job ID: "$JOBID
echo "SGE task ID: "$SGE_TASK_ID
echo "Run on host: "`hostname`
echo "Operating system: "`uname -s`
echo "Username: "`whoami`
echo "Started at: "`date`
echo "****************************************************"

echo "*****************************************************"
echo "Setting up paths and directories at: "`date`

cd /well/bag/will_sam/oxfordshire_overlap
mkdir -p ./analysis/panaroo/"$SGE_TASK_ID"

community=./cluster_members/"$SGE_TASK_ID".txt

panaroo=/well/bag/fnd111/miniconda3/bin/panaroo

while read sample;
do
	cp ./analysis/prokka/"$sample"/"$sample".gff ./analysis/panaroo/"$SGE_TASK_ID" 
done < $community

echo "Finished setting up at: "`date`
echo "****************************************************"

echo "*****************************************************"
echo "Running Panaroo at: "`date`

cd ./analysis/panaroo/"$SGE_TASK_ID"

$panaroo --clean-mode sensitive -i *.gff -o ./ --aligner mafft -a core --core_threshold 0.95 -t 16

rm *.gff

echo "Finished running Panaroo at: "`date`
echo "****************************************************"

echo "****************************************************"
echo "Finished at: "`date`
echo "****************************************************"
