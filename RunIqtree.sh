#!/bin/bash
#$ -S /bin/bash
#$ -N iqtree
#$ -j y
#$ -P bag.prjc
#$ -q long.qc -cwd -V
#$ -pe shmem 6

echo "****************************************************"
echo "SGE job ID: "$JOBID
echo "SGE task ID: "$SGE_TASK_ID
echo "Run on host: "`hostname`
echo "Operating system: "`uname -s`
echo "Username: "`whoami`
echo "Started at: "`date`
echo "****************************************************"

echo "*****************************************************"
echo "Running analysis at: "`date`

cd /well/bag/will_sam/oxfordshire_overlap
clusters=./iqtree_clusters.txt

iqtree=/well/bag/fnd111/miniconda3/bin/iqtree

cat $clusters | while read LINE; do
	mkdir -p ./analysis/iqtree/"$LINE"
	cd ./analysis/iqtree/"$LINE"
	cp /well/bag/will_sam/oxfordshire_overlap/analysis/panaroo/"$LINE"/core_gene_alignment.aln ./core_gene_alignment.aln	
	$iqtree -s ./core_gene_alignment.aln -m GTR+F+I+G4 -keep-ident -T 2 -B 1000
	cd /well/bag/will_sam/oxfordshire_overlap
done

echo "Finished analysis at: "`date`
echo "****************************************************"

echo "****************************************************"
echo "Finished at: "`date`
echo "****************************************************"
