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

## reshape dataframe and calculate stacked values
align_rates.m <- melt(align_rates.s, id=c("ids", "align_type"))
align_rates.m <- cast(align_rates.m, ids ~ align_type)
align_rates.m <- mutate(align_rates.m, 
                        unalign=100-genome,
                        genome=genome-cdna-rrna-mtrna)
align_rates.m$unalign[align_rates.m$genome<0] <- 0 
align_rates.m$genome[align_rates.m$genome<0] <- 0 
align_rates.m <- melt(align_rates.m, id="ids")

align_rates.m$variable <- as.factor(align_rates.m$variable)
align_rates.m$variable <- factor(align_rates.m$variable, 
                                 levels=rev(c("cdna", "mtrna", "genome",
                                          "rrna", "unalign")))

                            
theme_set(theme_classic())
g <- ggplot(align_rates.m, aes(x=ids, y=value, fill=variable)) +
        geom_bar(stat = "identity")
plot(g)
