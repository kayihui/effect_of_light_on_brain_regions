# This script is to construct DESeq2DataSet object(dds) after Kallisto 
# pseudoalignment, a list of abundance.h5 files, metatable containing samples
# and experimental design, and tx2gene table are required. The output of this 
# script is the DESeq2DataSet object, ready for further analysis

library(DESeq2)
library(tximport)
library(readr)
library(rhdf5)
source('~/Desktop/brainRNASeq/R_analysis/function/construct_DESeq2DataSet.R')

# read in the files with the list of transcipt ID corresponding to gene ID
tx2gene <- read_csv("~/Desktop/brainRNASeq/R_analysis/input_doc/tx2gene.csv")

# define the directory with the kallisto outputs
kallisto.output.directory <- "~/Desktop/brainRNASeq/pseudoalignment"

# read the csv file containing the metadata 
meta.data.SCN <- read_csv("~/Desktop/brainRNASeq/R_analysis/input_doc/meta_data_SCN.csv")
meta.data.LHb <- read_csv("~/Desktop/brainRNASeq/R_analysis/input_doc/meta_data_LHb.csv")
meta.data.VTA <- read_csv("~/Desktop/brainRNASeq/R_analysis/input_doc/meta_data_VTA.csv")
meta.data.NAc <- read_csv("~/Desktop/brainRNASeq/R_analysis/input_doc/meta_data_NAc.csv")


# construct the DESeq2DataSet objects
dds.SCN <- constructDESeq2DataSet(meta.data.SCN, tx2gene, kallisto.output.directory)
dds.LHb <- constructDESeq2DataSet(meta.data.LHb, tx2gene, kallisto.output.directory)
dds.VTA <- constructDESeq2DataSet(meta.data.VTA, tx2gene, kallisto.output.directory)
dds.NAc <- constructDESeq2DataSet(meta.data.NAc, tx2gene, kallisto.output.directory)


# set the workplace and save the DESeqDataSet object(dds) for later analysis
setwd("~/Desktop/brainRNASeq/R_analysis/R_output/DESeq2Objects")
saveRDS(dds.SCN, file = "SCN/SCN_DESeq2DataSet.RData")
saveRDS(dds.LHb, file = "LHb/LHb_DESeq2DataSet.RData")
saveRDS(dds.VTA, file = "VTA/VTA_DESeq2DataSet.RData")
saveRDS(dds.NAc, file = "NAc/NAc_DESeq2DataSet.RData")


# output the normalized count data and rlog transformed data
setwd("~/Desktop/brainRNASeq/R_analysis/R_output/results_tables")
write.csv(assay(dds.SCN), "SCN/SCN_normalized_gene_counts.csv", row.names = TRUE)
write.csv(assay(rlog(dds.SCN)), "SCN/SCN_rlog_transformated_data.csv", row.names = TRUE)

write.csv(assay(dds.LHb), "LHb/LHb_normalized_gene_counts.csv", row.names = TRUE)
write.csv(assay(rlog(dds.LHb)), "LHb/LHb_rlog_transformated_data.csv", row.names = TRUE)

write.csv(assay(dds.VTA), "VTA/VTA_normalized_gene_counts.csv", row.names = TRUE)
write.csv(assay(rlog(dds.VTA)), "VTA/VTA_rlog_transformated_data.csv", row.names = TRUE)

write.csv(assay(dds.NAc), "NAc/NAc_normalized_gene_counts.csv", row.names = TRUE)
write.csv(assay(rlog(dds.NAc)), "NAc/NAc_rlog_transformated_data.csv", row.names = TRUE)