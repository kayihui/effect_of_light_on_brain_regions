# This script is to convert DESeqResult object in to data frame with gene 
# annotations and remark. Please note this is a general script, please edit the 
# file names accordingly.

library(dplyr)

# source the add_gene_annotations and add_remark functions
source('~/Desktop/brainRNASeq/R_analysis/function/add_gene_annotations.R')
source('~/Desktop/brainRNASeq/R_analysis/function/add_remark.R')


# read in the gene annotation database, and select the information needed (
# ensembl_gene_id, mgi_symbol and the description)
gene.info <- read.csv("~/Desktop/brainRNASeq/R_analysis/input_doc/gene_info_database.csv",
											header = TRUE, stringsAsFactors = FALSE)
gene.info <- select(gene.info, ensembl_gene_id, mgi_symbol, description)
gene.info <- unique(gene.info)


# read in the DESeqResult object
setwd("~/Desktop/brainRNASeq/R_analysis/R_output/DESeq2Objects")
result.wt.light.treatment <- readRDS("WT_lightvsControl.RData")
result.Per1.light.treatment <- readRDS("Per1_lightvsControl.RData")
result.WTvsPer1.control <- readRDS("WTvsPer1_control.RData")
result.WTvsPer1.light.treatment <- readRDS("WTvsPer1_light.RData")
result.different.in.light.response <- readRDS("effectAcrossGenotype.RData")


# add the gene info and the remark
wt.light.treatment <- addGeneInfo(result.wt.light.treatment, gene.info)
wt.light.treatment <- addRemark(wt.light.treatment)

Per1.light.treatment <- addGeneInfo(result.Per1.light.treatment, gene.info)
Per1.light.treatment <- addRemark(Per1_lightvsControl)

WTvsPer1.control <- addGeneInfo(result.WTvsPer1.control, gene.info)
WTvsPer1.control <- addRemark(WTvsPer1.control)

WTvsPer1.light.treatment <- addGeneInfo(result.WTvsPer1.light.treatment, gene.info)
WTvsPer1.light.treatment <- addRemark(WTvsPer1.light.treatment)

different.in.light.response <- addGeneInfo(result.different.in.light.response, gene.info)
different.in.light.response<- addRemark(different.in.light.response)


# save the dataframe into .csv format
setwd("~/Desktop/brainRNASeq/R_analysis/R_output/results_tables")
write.csv(wt.light.treatment, "WT_lightvsControl.csv", row.names = FALSE)
write.csv(Per1.light.treatment, "Per1_lightvsControl.csv", row.names = FALSE)
write.csv(WTvsPer1.control, "WTvsPer1_control.csv", row.names = FALSE)
write.csv(WTvsPer1.light.treatment, "WTvsPer1_light.csv", row.names = FALSE)
write.csv(different.in.light.response, "effectAcrossGenotype.csv", row.names = FALSE)


# construct a dataframe with all the comparsions (for the ShinyApp)
result1 <- wt.light.treatment
result2 <- Per1.light.treatment
result3 <- WTvsPer1.control
result4 <- WTvsPer1.light.treatment
result5 <- different.in.light.response

result1$comparsion <- "WT (control vs Light)"
result2$comparsion <- "Per1 (control vs Light)"
result3$comparsion <- "WT vs Per1 (control)"
result4$comparsion <- "WT vs Per1 (Light)"
result5$comparsion <- "Different of light response between Per1 and WT"
# joining all the dataframe
Fulltable <- rbind(result1, result2, result3, result4, result5)
# define the column order
column.order <- c("comparsion", "baseMean", "log2FoldChange","pvalue","padj","lfcSE","stat","remark",
									"ensembl_gene_id","mgi_symbol","description")
# reorder the a
Fulltable <- Fulltable[, column.order]
write.csv(Fulltable, "all_comparsion.csv", row.names = FALSE)

