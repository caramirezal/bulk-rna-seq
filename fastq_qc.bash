export PATH=$PATH:sc/FastQC

## setting path where fastq files are stored
path2fastq=/Volumes/Untitled/ABRAHAN-106648929/FASTQ_Generation_2018-12-10_17_23_26Z-142394763/
echo $path2fastq 
 
fnames=$(find $path2fastq -type f)
for i in $fnames; do
     fastqc $i -o reports/FastQC
done

