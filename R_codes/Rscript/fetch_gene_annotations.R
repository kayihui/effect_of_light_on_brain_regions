# This script is used to fetch gene annotations data from the biomaRt database 

library(biomaRt)
library(dplyr)

ensembl <- useMart("ensembl", dataset="mmusculus_gene_ensembl")

# The gene_info_database will be used to add gene annotations to the results 
# from DESeq2 tables

gene.info.database <-getBM(attributes = c("ensembl_gene_id_version", 
																					"mgi_symbol", 
																					"description", 
																					"go_id", 
																					"ensembl_gene_id",
																					"ensembl_transcript_id_version", 
																					"ensembl_transcript_id"), 
													 mart=ensembl)

write.csv(gene.info.database, "gene_info_database.csv", row.names = FALSE)


# the tx2gene, transcripts to gene, database will be a required lists for 
# converting data from kallisto output to DESeq2 object

tx2gene <- select(gene.info.database, ensembl_transcript_id_version, ensembl_gene_id)
colnames(tx2gene) <-c("enstxp", "ensgene")
write.csv(tx2gene, "tx2gene.csv", row.names = FALSE)

