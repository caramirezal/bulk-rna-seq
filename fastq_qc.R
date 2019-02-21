library(ShortRead)

path2fastq <- "/Volumes/Untitled/ABRAHAN-106648929/FASTQ_Generation_2018-12-10_17_23_26Z-142394763/A10A_L004-ds.f29a13388bd448af8535b30f9ea0d928"

quality = qa(dirPath=path2fastq, pattern=".fastq.gz$", type="fastq")
report(quality, type="html", dest="fastqQAreport")