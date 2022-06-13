#!/bin/bash
#$ -S /bin/bash
#$ -N coverage
#$ -j y
#$ -P bag.prjc
#$ -q short.qc -cwd -V
#$ -t 1-100

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

cd /well/bag/fnd111/ncbi-upload
# samples=/well/bag/fnd111/ncbi-upload/circularised_chromo.txt
samples=/well/bag/fnd111/ncbi-upload/uncircularised_chromo.txt

f=$(sed -n "$SGE_TASK_ID"p $samples)
echo "Working on ${f}"

mkdir ./coverage-output/$f

sr1=./uncirc/$f/"$f"_1.fastq.gz
sr2=./uncirc/$f/"$f"_2.fastq.gz
assembly=./uncirc/$f/unicycler_output/assembly.fasta

bwa=/well/bag/fnd111/miniconda3/bin/bwa
samtools=/well/bag/users/lipworth/miniconda3/bin/samtools
bedtools=/well/bag/fnd111/miniconda3/bin/bedtools

echo "Finished set up at: "`date`
echo "****************************************************"

echo "****************************************************"
echo "Running analysis: "`date`

$bwa index $assembly
$bwa mem $assembly $sr1 $sr2 > ./coverage-output/$f/bwa-output.sam

$samtools view -h -b -S ./coverage-output/$f/bwa-output.sam > ./coverage-output/$f/bwa-output.bam
$samtools view -b -F 4 ./coverage-output/$f/bwa-output.bam > ./coverage-output/$f/bwa-output-mapped.bam
$samtools sort ./coverage-output/$f/bwa-output-mapped.bam > ./coverage-output/$f/bwa-output-mapped-sorted.bam

$bedtools genomecov -ibam ./coverage-output/$f/bwa-output-mapped-sorted.bam -d > ./coverage-output/$f/coverage.txt

grep -e '^1\s' ./coverage-output/$f/coverage.txt | cut -f3 | awk '{if(min==""){min=max=$1}; if($1>max) {max=$1}; if($1<min) {min=$1}; total+=$1; count+=1} END {print total/count, max, min}' > ./coverage-output/$f/coverage-summary.txt

rm -f ./coverage-output/$f/bwa-output*
rm -f ./coverage-output/$f/coverage.txt

echo "Finished working on ${f}"

echo "Finished at: "`date`
echo "*****************************************************"

echo "*****************************************************"
echo "Finished!"
echo "*****************************************************"

# grep ">1" -rnw --include=\*.fasta './assemblies' | grep "true" | cut -d / -f 3 > circularised_chromo.txt
# grep ">1" -rnw --include=\*.fasta './assemblies' | grep -v "true" | cut -d / -f 3 > uncircularised_chromo.txt

# for f in $(<circularised_chromo.txt); do cp -r ./assemblies/"$f" ./circ; done
# for f in $(<uncircularised_chromo.txt); do cp -r ./assemblies/"$f" ./uncirc; done

# cat all.txt | while read line; do echo "$line"; cat ./coverage-output/"$line"/coverage-summary.txt; done > all-coverage.txt
