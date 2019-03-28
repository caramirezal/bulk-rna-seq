## Visualization of the quantified alignments

library(ballgown)
library(dplyr)
library(genefilter)
library(devtools)
library(RSkittleBrewer)
library(googlesheets)

sheet <- gs_title("metada_bulk_RNA_astrocitomas")
pheno_data <- gs_read(sheet)
pheno_data$Muestra

pheno_data <- mutate(pheno_data, Muestra=gsub(" |-|\\(|\\)", "", Muestra))
names(pheno_data)[1] <- "ids"
pheno_data$ids
pheno_data$ids <- paste0(pheno_data$ids, ".ballgown.gtf", sep ="")
pheno_data <- as.data.frame(pheno_data)

rna_quant <- ballgown(samples = "data/quant/ballgown/")
list.files("data/quant/ballgown/")
