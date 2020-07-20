# This script is to generate the dataframe with all the experimental results from
# DESeq2 and combined with Gene Ontology (GO) information. The outout of this 
# script is one of the required document for the ShinyApp: download_dataset.

library(dplyr)
library(tidyr)

# load the database with the GO description
setwd("~/Desktop/brainRNASeq/R_analysis/input_doc")
gene.info <- read.csv("gene_info_database.csv", header = TRUE, stringsAsFactors = FALSE)

setwd("~/Desktop/brainRNASeq/R_analysis/R_output/results_tables")
SCN.data <- read.csv("SCN/SCN_all_comparsion.csv", header = TRUE, stringsAsFactors = FALSE)
VTA.data <- read.csv("~/Desktop/brainRNASeq/R_analysis/VTA_v2/VTA_v2_all_comparsion.csv", header = TRUE, stringsAsFactors = FALSE)
NAc.data <- read.csv("NAc/NAc_all_comparsion.csv", header = TRUE, stringsAsFactors = FALSE)
LHb.data <- read.csv("LHb/LHb_all_comparsion.csv", header = TRUE, stringsAsFactors = FALSE)

# adding the brain_region column
SCN.data$brain_region <- "SCN"
VTA.data$brain_region <- "VTA"
NAc.data$brain_region <- "NAc"
LHb.data$brain_region <- "LHb"

# combine the results from different brain regions
full.data <- rbind(SCN.data, VTA.data, NAc.data, LHb.data)

# select the Gene Ontology id and the gene id
gene2GO <- select(gene.info, go_id, ensembl_gene_id)
gene2GO <- unique(gene2GO)

# reformat the dataframe: each unique gene id per row, if a gene has more than
# one GO id, the GO id will be 'collected' into one single column.
gene2GO.newformat <- gene2GO %>% group_by(ensembl_gene_id) %>% mutate(All_GO_id = paste(go_id, collapse = ", "))
gene2GO.newformat <- select(gene2GO.newformat, -go_id)
gene2GO.newformat <- unique(gene2GO.newformat)
ungroup(gene2GO.newformat)
gene2GO.newformat <- unique(gene2GO.newformat)
gene2GO.newformat <- as.data.frame(gene2GO.newformat)

# joining the data with the reshaped GO info
data.with.GO <- left_join(full.data, gene2GO.newformat, by="ensembl_gene_id")
colnames(data.with.GO)[13] <-"GO_id"

column.order <- c("baseMean","log2FoldChange","pvalue","padj","lfcSE","stat",
                  "remark","ensembl_gene_id","mgi_symbol","description",
                  "GO_id","brain_region","comparsion")      
data.with.GO <- data.with.GO[ ,column.order]

setwd("~/Desktop/brainRNASeq/InteractiveApps/data_table_VTA2")
write.csv(data.with.GO,"full_data_withGO.csv", row.names = FALSE)
