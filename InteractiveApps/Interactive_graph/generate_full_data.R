# This script is to generate the dataframe with all the experimental results from
# DESeq2 and combined with Gene Ontology (GO) information. The outout of this 
# script is one of the required document for the ShinyApp: download_dataset.

library(dplyr)
library(tidyr)

setwd("~/Desktop/brainRNASeq/R_analysis/R_output/results_tables")
SCN.data <- read.csv("SCN/SCN_all_comparsion.csv", header = TRUE, stringsAsFactors = FALSE)
VTA.data <- read.csv("VTA/VTA_all_comparsion.csv", header = TRUE, stringsAsFactors = FALSE)
NAc.data <- read.csv("NAc/NAc_all_comparsion.csv", header = TRUE, stringsAsFactors = FALSE)
LHb.data <- read.csv("LHb/LHb_all_comparsion.csv", header = TRUE, stringsAsFactors = FALSE)

# adding the brain_region column
SCN.data$brain_region <- "SCN"
VTA.data$brain_region <- "VTA"
NAc.data$brain_region <- "NAc"
LHb.data$brain_region <- "LHb"

# combine the results from different brain regions
full.data <- rbind(SCN.data, VTA.data, NAc.data, LHb.data)

column.order <- c("baseMean","log2FoldChange","pvalue","padj","lfcSE","stat",
                  "remark","comparsion", "ensembl_gene_id","mgi_symbol","description",
                  "brain_region")      
full.data <- full.data[ ,column.order]

setwd("~/Desktop/brainRNASeq/InteractiveApps/Interactive_graph")
write.csv(full.data,"full_data.csv", row.names = FALSE)
