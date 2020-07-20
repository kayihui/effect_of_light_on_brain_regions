generateCountDataForPlot <- function(metadata, gene.info.annotation, count.data){
	# This function is to generate a dataframe with the normalized count from the 
	# DESeq2, and add metadata and gene annotations
	# Args: 
	#   metadata: dataframe with the metadata about the RNAseq experiment
	#   gene.info.annotation: dataframe with the gene annotation information
	#   count.data: dataframe with the normalized count data from DESseq2 analysis
	# Output: dataframe countdata ready for plot
	
	require(tidyr)
	require(dplyr)
	require(readr)
	
	# change colume name to make sure the first column is the gene ID
	colnames(count.data)[1] <- "ensembl_gene_id"
	
	# reshape the data into long form, column 2 to 24/23 when one sample is omitted
	count.data <- gather(count.data, key = "sample", counts, 2:(length(metadata$sample)+1))
	
	# add the metadata about the samples
	count.data <- left_join(count.data, metadata, by = "sample")
	
	# remove the filenames
	count.data <- select(count.data, -file_name)
	
	# create a new column, experiment combining the information in column genotype 
	# and condition
	count.data <- mutate(count.data, "experiment" = paste(genotype, condition, sep = "-"))
	count.data$experiment <- as.factor(count.data$experiment)
	count.data$experiment <- factor(count.data$experiment, 
																	levels = c("WT-control", 
																						 "WT-light_induced", 
																						 "Per1-control", 
																						 "Per1-light_induced"))
	
	# adding the gene info
	Id2name <- select(gene.info.annotation, ensembl_gene_id, mgi_symbol)
	Id2name <- unique(Id2name)
	count.data <- left_join(count.data, Id2name, by = "ensembl_gene_id")
	
	return(count.data)
}