require(dplyr)

addGeneInfo <- function(DESeq2Results, gene.info.database){
	# add detailed gene annotations to the DESeqResults object by ensembl_gene_id
	#
	# Args:
	#  DESeq2Results: DESeqResults object
	#  gene.info.database: dataframe from biomart
	#
	# Returns:
	#  dds.result.dataframe: dataframe with detailed gene annotations

	DESeq2Results$ensembl_gene_id <- sapply (strsplit(rownames(DESeq2Results), 
																												split="\\+"), "[", 1)
	dds.result.dataframe <- as.data.frame(DESeq2Results@listData)
	dds.result.dataframe <- left_join(dds.result.dataframe, gene.info.database, 
																		by ="ensembl_gene_id")
	return(dds.result.dataframe)
}