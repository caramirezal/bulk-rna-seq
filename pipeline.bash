## RNA quantification pipeline

## Loading dependencies
#export PATH=$PATH:inst/stringtie/
#export PATH=$PATH:inst/samtools-1.9

## path to star
star_PATH=sc/STAR/bin/MacOSX_x86_64/STAR

## indexing genome
echo RUNNING:./$star_PATH --runMode genomeGenerate --genomeDir data/star_indexed_genome/ --genomeFastaFiles data/reference_genome/Homo_sapiens.GRCh38.dna.primary_assembly.fa --sjdbOverhang 100 --sjdbGTFfile data/annotations/Homo_sapiens.GRCh38.96.gtf --runThreadN 18
./$star_PATH --runMode genomeGenerate --genomeDir data/star_indexed_genome/ --genomeFastaFiles data/reference_genome/Homo_sapiens.GRCh38.dna.primary_assembly.fa --sjdbOverhang 100 --sjdbGTFfile data/annotations/Homo_sapiens.GRCh38.96.gtf --runThreadN 18

## indexing mitochondria
#./$star_PATH --runMode genomeGenerate --genomeDir data/star_indexed_mit --genomeFastaFiles data/mitocondria/homo_sap_mitocondria.fa --runThreadN 16 --genomeSAindexNbases 6

## indexing ribosomal unit
#./$star_PATH --runMode genomeGenerate --genomeDir data/star_indexed_ribo --genomeFastaFiles data/ribosomal/human_rrna.fa --runThreadN 16

## indexing cdna
#./$star_PATH --runMode genomeGenerate --genomeDir data/star_indexed_cdna --genomeFastaFiles data/reference_genome/Homo_sapiens.GRCh38.cdna.all.fa --runThreadN 16 --limitGenomeGenerateRAM=10000000000000

## alignment to ribosomal unit 
#./$star_PATH --readFilesIn data/qual_check/sample_seqs/M94_S20_L005_R1_001.fastq data/qual_check/sample_seqs/M94_S20_L005_R2_001.fastq --genomeDir data/star_indexed_ribo/ --runThreadN 16 --outFileNamePrefix data/qual_check/star/


