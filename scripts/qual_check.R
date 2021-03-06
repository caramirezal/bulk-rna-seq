## Assesing quality of the RNA bulk sequences
library(dplyr)
library(ggplot2)
library(reshape)
library(reshape2)


## extract full paths
summaries <- list.files("../data/qual_check/star", recursive = TRUE)
f_path <- paste0("../data/qual_check/star/", summaries)

## extract alignment rates
extract_align_rate <- function(path){
        content <- readLines(path)
        content <- content[grep("Uniquely mapped reads %", content)]
        rate <- gsub(".*\t", "", content)
        rate <- gsub("%", "", rate)
        as.numeric(rate)
}

## perform rate extraction
rates <- sapply(f_path, function(x) extract_align_rate(x))
rates

## Tide data
align_rates <- data.frame("full_paths" = names(rates), 
                          "rates" = rates)

## extract sample ids from paths
align_rates <- mutate(align_rates, ids=gsub("Log.*|-Log.*", "", full_paths)) %>%
                        mutate(ids=gsub(".*/", "", ids)) %>%
                            mutate(ids=gsub("-.*", "", ids))

## extract alignment type
align_rates <- mutate(align_rates, 
                      align_type=gsub("../data/qual_check/star/", "", full_paths)) %>%
                           mutate(align_type=gsub("Log.*|-Log.*", "", align_type)) %>%
                           mutate(align_type=gsub(".*-", "", align_type))


## remove unwanted rows and cols
#align_rates.s <- filter(align_rates, align_type!="cdna_n_mtrna") %>%
#        filter(ids !="") %>%
#        mutate(ids=gsub("\\.", "", ids)) %>%
align_rates.s <- select(align_rates, rates:align_type)

## reshape dataframe and calculate unaligned sequences
align_rates.m <- melt(align_rates.s, id=c("ids", "align_type"))
#align_rates.m
align_rates.c <- cast(align_rates.m, ids ~ align_type)
align_rates.c <- mutate(align_rates.c, unalign=100-genome) 
align_rates.c

##################################################################################
## stacked barplot

## data processing for stacked barplot of rna alignments
align_rates.rna <- melt(align_rates.c, id="ids")
align_rates.rna <- filter(align_rates.rna, variable!="genome")
align_rates.rna$variable <- as.factor(align_rates.rna$variable)
align_rates.rna$variable <- factor(align_rates.rna$variable, 
                                 levels=rev(c("mtrna",
                                          "rrna", "unalign")))

## stacked bar plot
theme_set(theme_bw())
g <- ggplot(data=align_rates.rna, aes(x=ids, y=value, fill=variable)) +
            geom_bar(stat = "identity") + 
            labs(x="", y="% Alignment") +
            theme(axis.text.x = element_text(face="bold", size = 10),
                  text = element_text(face="bold", size = 16))
#g <- g + geom_hline(yintercept=mean(align_rates.m$genome), 
#                    linetype="dashed", 
#                    color="black", 
#                    size=1)
#g <- g + geom_text(x=2, y=96, label="Alignment to Genome", size=4, color="steelblue")
plot(g)

#################################################################################
## paired sample

paired <- filter(align_rates, align_type %in% c("cdna", "cdna_n_mtrna")) %>%
            filter(ids !="") %>%
              mutate(ids=gsub("\\.", "", ids)) %>%
                select(rates:align_type)
paired <- melt(paired, id=c("ids", "align_type")) 
paired$align_type <- sapply(paired$align_type, function(x)
                             ifelse(x=="cdna", x, "cdna + mrna")) 

g <- ggplot(paired, aes(x=align_type, y=value, label=ids)) + 
        geom_point(colour="steelblue") +
        geom_text(colour="green") +
        geom_line(aes(group = ids), colour="steelblue") +
        labs(x="", y="% Alignment") +
        theme(text = element_text(face="bold", size = 22))
plot(g)
