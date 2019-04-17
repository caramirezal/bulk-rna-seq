export PATH=$PATH:~/scripts/bulk-rna-seq/inst/seqtk


## setting directory where fastq are stored
fastq_dir=$(ls data/qual_check/sample_seqs | grep .fastq | sed "s/_R[12]_001.fastq//g" | uniq )

## Alignment to mitochondria
for file in $fastq_dir; do
#	echo "####################################################################################################################"


	## run alignment to mtrna
	echo RUNNING: hisat2 -x data/hisat_indexed_mitocondria/homo_sap_mitocon -1 data/qual_check/sample_seqs/${file}_R1_001.fastq -2 data/qual_check/sample_seqs/${file}_R2_001.fastq -S temporal.sam -p 24 --summary-file data/qual_check/mtrna/${file}.hisat_alignment_summary_file.txt
	hisat2 -x data/hisat_indexed_mitocondria/homo_sap_mitocon -1 data/qual_check/sample_seqs/${file}_R1_001.fastq -2 data/qual_check/sample_seqs/${file}_R2_001.fastq -S temporal.sam -p 24 --summary-file data/qual_check/mtrna/${file}.hisat_alignment_summary_file.txt
	
	## removing sam file
	echo removing sam
        rm temporal.sam
done 


for file in $fastq_dir; do
#	echo "####################################################################################################################"


	## run alignment to mtrna
	echo RUNNING: hisat2 -x data/hisat_indexed_mitocondria/homo_sap_mitocon -1 data/qual_check/sample_seqs/${file}_R1_001.fastq -2 data/qual_check/sample_seqs/${file}_R2_001.fastq -S temporal.sam -p 24 --summary-file data/qual_check/mtrna/${file}.hisat_alignment_summary_file.txt
	hisat2 -x data/hisat_indexed_mitocondria/homo_sap_mitocon -1 data/qual_check/sample_seqs/${file}_R1_001.fastq -2 data/qual_check/sample_seqs/${file}_R2_001.fastq -S temporal.sam -p 24 --summary-file data/qual_check/mtrna/${file}.hisat_alignment_summary_file.txt
	
	## removing sam file
	echo removing sam
        rm temporal.sam
done 
