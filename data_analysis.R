## Visualization of the quantified alignments

## Loading dependencies
library(ballgown)
library(dplyr)
library(genefilter)
library(devtools)
library(RSkittleBrewer)
library(googlesheets)

## Loading metada
sheet <- gs_title("metada_bulk_RNA_astrocitomas")
pheno_data <- gs_read(sheet)
pheno_data$Muestra
## Data cleaning
pheno_data <- mutate(pheno_data, Muestra=gsub(" |-|\\(|\\)", "", Muestra))
names(pheno_data)[1] <- "ids"
pheno_data$ids
pheno_data$ids <- paste0("cnss", pheno_data$ids, sep ="")
pheno_data <- as.data.frame(pheno_data)
pheno_data <- pheno_data[order(pheno_data$ids),]

rna_quant <- ballgown(dataDir = "data/quant/ballgown/", 
                      samplePattern = "cnss", 
                      pData = pheno_data)

rna.matrix <- texpr(rna_quant, meas = "all")

write.table(rna.matrix, 
            "data/quant/cns_expresion.tsv", 
            sep = "\t", 
            row.names = FALSE, 
            quote = FALSE)
