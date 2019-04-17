export PATH=$PATH:~/scripts/bulk-rna-seq/inst/seqtk


## setting directory where fastq are stored
fastq_dir=$(find /Volumes/Untitled/ABRAHAN-106648929/ | grep fastq.gz)

## Iteration of the pipeline to process all fastq sample files
for file in $fastq_dir; do
#	echo "####################################################################################################################"
#
#	## getting sample name
	samp_name=$(echo $file | sed "s/.fastq.*//g")
	samp_name=$(echo $samp_name | sed "s/.*\///g")
	echo Processin sample: $samp_name
#
#
#	## alignment
	seqtk sample -s33 $file 10000 > data/qual_check/sample_seqs/$samp_name.fastq 
#
#	hisat2 -x data/grch38_snp_tran/genome_snp_tran -1 $file/*1_001.fastq.gz -2 $file/*2_001.fastq.gz -S data/sam/hisat2/$samp_name.sam -p 24 --summary-file reports/$samp_name.hisat_alignment_summary_file.txt
#
done 
