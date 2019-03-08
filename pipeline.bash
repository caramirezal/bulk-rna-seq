## RNA quantification pipeline

## building indexed genome
## Needs to be run just once
#hisat2-build -p 24 data/reference_genome/Homo_sapiens.GRCh38.cdna.all.fa data/indexed_ref_genome/homo_sap

## alignment
hisat2 -x data/indexed_ref_genome/homo_sap -1  data/raw_data_example/A10A_S16_L004_R1_001.fastq.gz -2 data/raw_data_example/A10A_S16_L004_R2_001.fastq.gz -S data/alignment.sam -p 24


## salmon index building
salmon index -t data/reference_genome/Homo_sapiens.GRCh38.cdna.all.fa -i data/salmon_indexed_genome/homo_sap

## salmon quantification
salmon quant -i data/salmon_indexed_genome/homo_sap -l A  -1 data/raw_data/A10A_S16_L004_R1_001.fastq.gz -2 data/raw_data/A10A_S16_L004_R2_001.fastq.gz -p 24 -o data/salmon_quant
