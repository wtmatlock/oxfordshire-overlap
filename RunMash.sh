#!/bin/bash
#$ -S /bin/bash
#$ -N mash
#$ -j y
#$ -P bag.prjc
#$ -q long.qc -cwd -V
#$ -pe shmem 12

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
mkdir ./analysis/mash

mash=/well/bag/fnd111/miniconda3/bin/mash

echo "Finished set up at: "`date`
echo "****************************************************"

echo "****************************************************"
echo "Running analysis at: "`date`

# for f in ./all_plasmids/*.fasta; do $mash sketch -s 1000000 "$f"; done
# for f in ./plsdb/*.fasta; do $mash sketch -s 1000000 "$f"; done

$mash triangle -E ./all_plasmids/*.msh ./plsdb/*.msh > ./analysis/mash/plsdb_edgelist.tsv

echo "Finished at: "`date`
echo "*****************************************************"

echo "*****************************************************"
echo "Finished!"
echo "*****************************************************"

