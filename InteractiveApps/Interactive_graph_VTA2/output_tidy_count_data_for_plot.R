library(tidyr)
library(dplyr)
library(readr)
source('~/Desktop/brainRNASeq/InteractiveApps/Interactive_graph/generate_count_data_for_plot.R')

setwd("~/Desktop/brainRNASeq/R_analysis")
# Table with the gene annotations
gene.info <- read.csv("input_doc/gene_info_database.csv", header = TRUE, stringsAsFactors = FALSE)

# read the csv files containing the metadata 
# metadata.SCN <- read_csv("meta_data_SCN.csv")
metadata.VTA <- read_csv("VTA_v2/meta_data_VTA_v2.csv")
# metadata.LHb <- read_csv("meta_data_LHb.csv")
# metadata.NAc <- read_csv("meta_data_NAc.csv")

setwd("~/Desktop/brainRNASeq/R_analysis/R_output/results_tables")
#countData.SCN <- read.csv("SCN/SCN_normalized_gene_counts.csv",header = TRUE, stringsAsFactors = FALSE)
countData.VTA <- read.csv("VTA_v2/VTA_v2_normalized_gene_counts.csv",header = TRUE, stringsAsFactors = FALSE)
#countData.LHb <- read.csv("LHb/LHb_normalized_gene_counts.csv",header = TRUE, stringsAsFactors = FALSE)
#countData.NAc <- read.csv("NAc/NAc_normalized_gene_counts.csv",header = TRUE, stringsAsFactors = FALSE)

# use the function generateCountDataForPlot to add information to the count data 
# and also reshape the dataframe to long form from ggplot2
# countData.plot.SCN <- generateCountDataForPlot(metadata.SCN, gene.info, countData.SCN)
countData.plot.VTA <- generateCountDataForPlot(metadata.VTA, gene.info, countData.VTA)
# countData.plot.LHb <- generateCountDataForPlot(metadata.LHb, gene.info, countData.LHb)
# countData.plot.NAc <- generateCountDataForPlot(metadata.NAc, gene.info, countData.NAc)

# output the files for plotting graphs
setwd("~/Desktop/brainRNASeq/InteractiveApps/Interactive_graph_VTA2")
# write.csv(countData.plot.SCN, "SCN_count_ready_for_plot.csv", row.names = FALSE)
write.csv(countData.plot.VTA, "VTA_v2_count_ready_for_plot.csv", row.names = FALSE)
# write.csv(countData.plot.LHb, "LHb_count_ready_for_plot.csv", row.names = FALSE)
# write.csv(countData.plot.NAc, "NAc_count_ready_for_plot.csv", row.names = FALSE)
