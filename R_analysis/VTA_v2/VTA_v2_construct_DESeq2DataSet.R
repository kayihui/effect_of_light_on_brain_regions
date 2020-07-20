# This script is to construct DESeq2DataSet object(dds) after Kallisto 
# pseudoalignment, a list of abundance.h5 files, metatable containing samples
# and experimental design, and tx2gene table are required. The output of this 
# script is the DESeq2DataSet object, ready for further analysis

library(DESeq2)
source('~/Desktop/brainRNASeq/R_analysis/function/construct_DESeq2DataSet.R')

dds <- readRDS("VTA_v2_DESeq2.RData")

# set the workplace and save the DESeqDataSet object(dds) for later analysis
# output the normalized count data and rlog transformed data
write.csv(assay(dds), "VTA_v2_normalized_gene_counts.csv", row.names = TRUE)
write.csv(assay(rlog(dds)), "VTA_v2_rlog_transformated_data.csv", row.names = TRUE)
