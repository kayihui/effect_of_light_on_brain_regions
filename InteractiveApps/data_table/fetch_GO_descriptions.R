# This script is to download GO terms and it's corresponding descriptions

library(GO.db)

keys <- keys(GO.db)
myGOdb <- select(GO.db, keys=keys, columns=c("TERM","ONTOLOGY", "DEFINITION"), 
								 keytype="GOID")

setwd("~/Desktop/brainRNASeq/InteractiveApps/data_table")
write.csv(myGOdb,"GO_description.csv", row.names = FALSE)