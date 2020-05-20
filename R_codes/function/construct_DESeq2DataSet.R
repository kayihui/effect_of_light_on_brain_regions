constructDESeq2DataSet <- function(metadata, tx2gene, directory){
  # This function is to construct DESeq2DataSet object(dds) after Kallisto 
  # pseudoalignment, a list of abundance.h5 files, metatable containing samples
  # and experimental design, and tx2gene table are required. The output of this 
  # script is the DESeq2DataSet object, ready for further analysis
	# Args:
	#  metadata: metadata containing the experimental details
	#  tx2gene: converting transcript id to gene id
	#  directory: the directory where the abundance.h5 files are located
	# output: DESeq2DataSet object(dds)

  require(DESeq2)
	require(tximport)
	require(readr)
	require(rhdf5)

  # get the paths of the kallisto outputs (abundance.h5 files) for all the samples 
  # and test if the files exists
  abundance.h5.files <- file.path(kallisto.output.directory, "output", 
  																metadata$file_name, "abundance.h5")
  names(abundance.h5.files) <- metadata$sample
  
  # condition to stop the function if not all the abundance.h5 exists
  if (sum(file.exists(abundance.h5.files)) != length(abundance.h5.files)) {
  	stop("Not all the files exist!")
  }

  # use tximport to combine the abundance.h5 files, and conventing the transcript 
  # ID into gene ID
  abundance.all.samples <- tximport(abundance.h5.files, type = "kallisto", 
																	tx2gene = tx2gene)

  # define the experimental design 
  experimental.design <- ~ genotype + condition + genotype:condition

  # creating the DESeqDataSet object(dds) from Tximport
  dds <- DESeqDataSetFromTximport(abundance.all.samples, metadata, 
																design = experimental.design)

  # relevel to make sure that the reference is wildtype 'WT'
  dds$genotype <- relevel(dds$genotype, "WT")

  # filtering out the genes that have too low expression, defualt here is set to
  # 25, which means that the sum of the counts of all samples of that gene needs 
  # to be larger that 25
  dds <- dds[rowSums(counts(dds)) > 25, ]

  # creating the DESeqDataSet object again
  dds <- DESeq(dds)
  
  return(dds)
}

