addRemark <- function(dds.result){
	# adding a remark column which grouping the genes according to fold change and
	# padj
	#
	# Args: 
	#  dds.result: dataframe generated from DESeqResults object
	#
	# Return:
	# dds.result: dataframe with a column called remark, which indicate
	#             if the fold change of the gene expression is significant
	
	# NAs in padj and pvalue are converted to 1
	dds.result$padj[is.na(dds.result$padj)] <- 1
	dds.result$pvalue[is.na(dds.result$pvalue)] <- 1
	
	# create the remark column with the default value "not significant"
	dds.result$remark <- "not significant"
	
	# if the pajd is less than 0.1, remark changed to "significant"
	dds.result$remark[dds.result$padj < 0.1 ] <- "significant"
	
	# if the absolute value of log2FoldChange is larger than 1 and , remark 
	# changed to "more than 1-fold"
	dds.result$remark[(abs(dds.result$log2FoldChange) > 1) ] <- "more than 1-fold"
	
	# if the absolute value of log2FoldChange is larger than 1 and 
	dds.result$remark[(abs(dds.result$log2FoldChange) > 1) & 
											(dds.result$padj < 0.1)] <- "significant & more than 1-fold"
	
	# change the remark column from character to factor
	dds.result$remark <- as.factor(dds.result$remark)
	
	return(dds.result)
}