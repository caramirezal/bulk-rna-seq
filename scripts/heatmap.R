library(plyr)
library(dplyr)
library(googlesheets)

## prereading expression matrix
cns <- read.table("../data/quant/cns_expresion.tsv", 
                  sep="\t", 
                  header=TRUE, 
                  nrows=10)

## prereading metadata
metadata <- gs_title("Astrocitomoas y sus clasificaciones")
metadata.s <- gs_read(metadata)
str(metadata.s)
head(metadata.s)

## reading data
cns <- read.table("../data/quant/cns_expresion.tsv", 
                  sep="\t", 
                 header=TRUE)


## keeping names
gene_names <- cns[, c("gene_name", "t_name")] 

## selecting normalized values
selected_features <- grep("FPKM", colnames(cns), value=TRUE)
cns <- select(cns, selected_features)
colnames(cns) <- gsub("FPKM.cnss", "", colnames(cns))

## calculation of the correlation matrix
cns.cor.sp <- cor(cns, method = "spearman")
cns.cor.pe <- cor(cns, method = "pearson")

## assigning color to tumor categories 
metadata.s <- mutate(metadata.s, Muestra=gsub("\\(|\\)|-| ", "", Muestra))
metadata.s <- mutate(metadata.s, color_grado_hist=mapvalues(metadata.s$`Grado Histopatológico`,
                                                            from = unique(metadata.s$`Grado Histopatológico`),
                                                            to = c("yellow1", "yellow2", "orange", "red", 
                                                                 "green", "lightgreen")))
metadata.s <- mutate(metadata.s, Muestra=gsub("M46", "CM46", Muestra))
metadata.s <- arrange(metadata.s, Muestra)

jpeg("../figures/cnss_heatmap_PEARSON.jpg")
heatmap(cns.cor.pe, ColSideColors = metadata.s$color_grado_hist, RowSideColors = metadata.s$color_grado_hist)
dev.off()

jpeg("../figures/cnss_heatmap_spearman.jpg")
heatmap(cns.cor.sp, ColSideColors = metadata.s$color_grado_hist, RowSideColors = metadata.s$color_grado_hist)
dev.off()
