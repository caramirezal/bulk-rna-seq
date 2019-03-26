## RNA quantification pipeline

## Loading dependencies
export PATH=$PATH:inst/stringtie/
export PATH=$PATH:inst/samtools-1.9

## setting directory where fastq are stored
#fastq_dir=/Volumes/Untitled/ABRAHAN-106648929/FASTQ_Generation_2018-12-10_17_23_26Z-142394763/*

## Iteration of the pipeline to process all fastq sample files
#for file in $fastq_dir; do
#	echo "####################################################################################################################"
#
#	## getting sample name
#	samp_name=$(echo $file | sed "s/_L.*//g")
#	samp_name=$(echo $samp_name | sed "s/.*\///g")
#	echo Processin sample: $damp_name
#
#
#	## alignment
#	echo EXECUTING COMMAND: hisat2 -x data/grch38_snp_tran/genome_snp_tran -1 $file/*1_001.fastq.gz -2 $file/*2_001.fastq.gz -S data/sam/hisat2/$samp_name.sam -p 24 --summary-file reports/$samp_name.hisat_alignment_summary_file.txt
#
#	hisat2 -x data/grch38_snp_tran/genome_snp_tran -1 $file/*1_001.fastq.gz -2 $file/*2_001.fastq.gz -S data/sam/hisat2/$samp_name.sam -p 24 --summary-file reports/$samp_name.hisat_alignment_summary_file.txt
#
#
#
#	## sam to bam files
#	echo EXECUTING COMMAND: samtools sort -@ 24 -o data/bam/hisat2/$samp_name.bam data/sam/hisat2/$samp_name.sam
#
#	samtools sort -@ 24 -o data/bam/hisat2/$samp_name.bam data/sam/hisat2/$samp_name.sam
#
#	## Removing sam file
#	rm data/sam/hisat2/$samp_name.sam
#done

bam_dir=data/bam/hisat2/*
#for bam in $bam_dir; do
#	echo "####################################################################################################################"
#	## setting reference name
#	ref_name=$(echo $bam | sed "s/.*\///g")
#	ref_name=$(echo $ref_name | sed "s/.bam*//g")
#	echo Quantifying sample: $ref_name 

	## quantification
#	echo EXECUTING: stringtie -p 24 -G data/annotations/Homo_sapiens.GRCh38.95.gtf -o data/quant/stringtie/$ref_name.gtf -l $ref_name  $bam
#	stringtie -p 24 -G data/annotations/Homo_sapiens.GRCh38.95.gtf -o data/quant/stringtie/$ref_name.gtf -l $ref_name  $bam
#done

#stringtie --merge -p 24 -G data/annotations/Homo_sapiens.GRCh38.95.gtf -o data/quant/all_samples.gtf data/quant/quant_files_list.txt 

for bam in $bam_dir; do
	echo "####################################################################################################################"
	## setting reference name
	ref_name=$(echo $bam | sed "s/.*\///g")
	ref_name=$(echo $ref_name | sed "s/.bam*//g")
	echo Quantifying sample: $ref_name

       echo EXECUTING: stringtie –e –B -p 24 -G data/quant/all_samples.gtf -o data/quant/ballgown/$ref_name.ballgown.gtf data/bam/hisat2/$ref_name.bam
       stringtie -e -B -p 24 -G data/quant/all_samples.gtf -o data/quant/ballgown/$ref_name.ballgown.gtf data/bam/hisat2/$ref_name.bam        
done