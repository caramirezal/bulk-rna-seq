## RNA quantification pipeline

## Loading dependencies
export PATH=$PATH:inst/stringtie/
export PATH=$PATH:inst/samtools-1.9


####################################################################################################################################################################
## HISAT2, STRINGTIE pipeline

## building indexed genome
## Needs to be run just once
#hisat2-build -p 24 data/reference_genome/Homo_sapiens.GRCh38.cdna.all.fa data/indexed_ref_genome/homo_sap

## alignment
hisat2 -x data/grch38_snp_tran/genome_snp_tran -1  data/raw_data/A10A_S16_L004_R1_001.fastq.gz -2 data/raw_data/A10A_S16_L004_R2_001.fastq.gz -S data/sam/hisat2/A10A_S16_L004.sam -p 24 --summary-file reports/hisat_alignment_summary_file.txt

## transform sam to bam files 
samtools sort -@ 24 -o data/bam/hisat2/A10A_S16_L004.bam data/sam/hisat2/A10A_S16_L004.sam

## transcript quantification
stringtie -p 24 -G data/annotations/Homo_sapiens.GRCh38.95.gtf -o data/quant/stringtie/A10A_S16_L004.gtf -l A10A_S16_L004  data/bam/hisat2/A10A_S16_L004.bam


#####################################################################################################################################################################
## SALMON pipeline

## salmon index building
salmon index -t data/reference_genome/Homo_sapiens.GRCh38.cdna.all.fa -i data/salmon_indexed_genome/homo_sap

## salmon quantification
salmon quant -i data/salmon_indexed_genome/homo_sap -l A  -1 data/raw_data/A10A_S16_L004_R1_001.fastq.gz -2 data/raw_data/A10A_S16_L004_R2_001.fastq.gz -p 24 -o data/salmon_quant
