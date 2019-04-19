## Assesing quality of the RNA bulk sequences
library(dplyr)
library(ggplot2)
library(reshape)
library(reshape2)


## extract full paths
summaries <- list.files("../data/qual_check/", recursive = TRUE)
summaries <- summaries[grep("hisat_alignment_summary_file.txt", 
                            summaries)]
f_path <- paste0("../data/qual_check/", summaries)
f_path <- f_path[!grepl("R1|R2", f_path)]


## extract alignment rates
extract_align_rate <- function(path){
        content <- readLines(path)
        content <- content[grep("overall alignment rate", content)]
        rate <- gsub("% .*", "", content)
        as.numeric(rate)
}

## perform rate extraction
rates <- sapply(f_path, function(x) extract_align_rate(x))

## Tide data
align_rates <- data.frame("full_paths" = names(rates), 
                          "rates" = rates)
## extract sample ids from paths
align_rates <- mutate(align_rates, ids=gsub("_S.*|hisat.*", "", full_paths)) %>%
                        mutate(ids=gsub(".*/", "", ids))
## extract alignment type
align_rates <- mutate(align_rates, 
                      align_type=gsub("../data/qual_check/", "", full_paths)) %>%
                           mutate(align_type=gsub("/.*", "", align_type))

## remove unwanted rows and cols
align_rates.s <- filter(align_rates, align_type!="cdna_n_mtrna") %>%
        filter(ids !="") %>%
        mutate(ids=gsub("\\.", "", ids)) %>%
        select(rates:align_type)

## reshape dataframe and calculate unaligned sequences
align_rates.m <- melt(align_rates.s, id=c("ids", "align_type"))
align_rates.m <- cast(align_rates.m, ids ~ align_type)
align_rates.m <- mutate(align_rates.m, unalign=100-genome) 

## data processing for stacked barplot of rna alignments
align_rates.rna <- melt(align_rates.m, id="ids")
align_rates.rna <- filter(align_rates.rna, variable!="genome")
align_rates.rna$variable <- as.factor(align_rates.rna$variable)
align_rates.rna$variable <- factor(align_rates.rna$variable, 
                                 levels=rev(c("cdna", "mtrna",
                                          "rrna", "unalign")))

## stacked bar plot
theme_set(theme_light())
g <- ggplot(data=align_rates.rna, aes(x=ids, y=value, fill=variable)) +
            geom_bar(stat = "identity") + 
            labs(x="", y="% Alignment") +
            theme(axis.text.x = element_text(face="bold", size = 10),
                  text = element_text(face="bold", size = 16))
g <- g + geom_hline(yintercept=mean(align_rates.m$genome), 
                    linetype="dashed", 
                    color="black", 
                    size=1)
g <- g + geom_text(x=2, y=96, label="Alignment to Genome", size=4, color="steelblue")
plot(g)

