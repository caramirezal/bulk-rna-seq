export PATH=$PATH:sc/FastQC
<<<<<<< HEAD
export PATH=$PATH:~/.local/bin/cutadapt
=======
>>>>>>> 7c6812a871abd2b6d9ffc3b1d57d8433dad82a0f

####################################################################################################
## Fastqc quality check

## setting path where fastq files are stored
#path2fastq=/Volumes/Untitled/ABRAHAN-106648929/FASTQ_Generation_2018-12-10_17_23_26Z-142394763/
#echo $path2fastq 
 
#fnames=$(find $path2fastq -type f)
#for i in $fnames; do
#     fastqc $i -o reports/FastQC
#done

##################################################################################################
## alignments quality check
<<<<<<< HEAD
#path2bam=/Volumes/Untitled/
#echo $path2bam

#fastqc /Volumes/Untitled/*.bam -o reports/FastQC -t 64 

############################################################################# 
## Quality control

## Using trim_galore
trim_galore "/Volumes/Untitled\ 1/ABRAHAN-106648929/FASTQ_Generation_2018-12-10_17_23_26Z-142394763/A10A_L004-ds.f29a13388bd448af8535b30f9ea0d928/A10A_S16_L004_R1_001.fastq.gz" "/Volumes/Untitled\ 1/ABRAHAN-106648929/FASTQ_Generation_2018-12-10_17_23_26Z-142394763/A10A_L004-ds.f29a13388bd448af8535b30f9ea0d928/A10A_S16_L004_R2_001.fastq.gz" --fastqc --illumina --quality 26  --paired --output_dir data/ --path_to_cutadapt ~/.local/bin/cutadapt
=======
path2bam=/Volumes/Untitled/
echo $path2bam

fastqc /Volumes/Untitled/*.bam -o reports/FastQC -t 64 
 
>>>>>>> 7c6812a871abd2b6d9ffc3b1d57d8433dad82a0f
