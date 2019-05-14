#export PATH=$PATH:~/scripts/bulk-rna-seq/inst/seqtk

## path to star
star_PATH=sc/STAR/bin/MacOSX_x86_64/STAR

fastq_dir=$(ls data/qual_check/sample_seqs/ | sed 's/_R.*//g' | uniq)

## Alignment to mitochondria
for file in $fastq_dir; do
       ## construction of file names
       f1=$file\_R1_001.fastq
       f2=$file\_R2_001.fastq
       fname=$( echo $f1 | sed 's/_.*//g' )

       ## alignment to ribosomal unit      
       #./$star_PATH --readFilesIn data/qual_check/sample_seqs/$f1 data/qual_check/sample_seqs/$f2 --genomeDir data/star_indexed_ribo/ --runThreadN 16 --outFileNamePrefix data/qual_check/star/$fname-rrna-

       ## alignment to mitochondria
       ./$star_PATH --readFilesIn data/qual_check/sample_seqs/$f1 data/qual_check/sample_seqs/$f2 --genomeDir data/star_indexed_mit/ --runThreadN 16 --outFileNamePrefix data/qual_check/star/$fname-mtrna-
done 

