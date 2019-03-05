## Building a indexed reference genome

## hisat2 indexing
mkdir data/indexed_ref_genome/
hisat2-build -p 24 -f data/reference_genome/Homo_sapiens.GRCh38.cdna.all.fa.gz data/indexed_ref_genome/homo_sap_ 
