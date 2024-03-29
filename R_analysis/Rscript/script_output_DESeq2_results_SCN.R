# This script is to output the DESeq2Results object with different experimental 
# comparsion for the SCN region

library(DESeq2)

# read the saved DESeq2DataSet object
setwd("~/Desktop/brainRNASeq/R_analysis/R_output/DESeq2Objects")
dds <- readRDS("SCN/SCN_DESeq2DataSet.RData")

# extract the effect of light treatment in wild-type animals (DESeqResults object)
wt.light.treatment <- results(dds, contrast = c("condition", "light_induced", 
																								"control"))

# extract the effect of light treatment in Per1 mutant animals
Per1.light.treatment <- results(dds, list(c("condition_light_induced_vs_control", 
																						"genotypePer1.conditionlight_induced")))

# extract the genotype effect without light treatment
WTvsPer1.control <- results(dds, contrast = c("genotype", "Per1", "WT"))

# extract the genotype effect with light treatment 
WTvsPer1.light.treatment <- results(dds, list(c("genotype_Per1_vs_WT", 
																								"genotypePer1.conditionlight_induced")))

# extract the different light treatment response comparing WT and Per1 mutants, 
# i.e. the interaction term in the experimental design formula
different.in.light.response <- results(dds, name = "genotypePer1.conditionlight_induced")

# set the workplace and save the DESeqDataSet object(dds) for later analysis
setwd("~/Desktop/brainRNASeq/R_analysis/R_output/DESeq2Objects")
saveRDS(wt.light.treatment, "SCN/SCN_WT_lightvsControl.RData")
saveRDS(Per1.light.treatment, "SCN/SCN_Per1_lightvsControl.RData")
saveRDS(WTvsPer1.control, "SCN/SCN_WTvsPer1_control.RData")
saveRDS(WTvsPer1.light.treatment, "SCN/SCN_WTvsPer1_light.RData")
saveRDS(different.in.light.response, "SCN/SCN_effectAcrossGenotype.RData")
