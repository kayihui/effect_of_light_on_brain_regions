# This script is to generate the dataframe with all the experimental results from
# DESeq2. The outout of this script is one of the required document for the 
# ShinyApp: interactive_volcano_plot.

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

setwd("~/Desktop/brainRNASeq/InteractiveApps/interactive_volcano_plot")
write.csv(full.data,"full_table.csv", row.names = FALSE)