make_customdb <- function(interaction_nodes,gene_info,enrich=NULL){
  Protein2Gene <- read.csv(interaction_nodes,sep="\t")[,c(1,2)]
  tmp1 <- Protein2Gene[,1]
  tmp2 <- Protein2Gene[,2]
  if (is.null(enrich)){}
  else
  {
    Protein2Gene[,3] <- enrich
    colnames(Protein2Gene[,3]) <- "evidence"
  }
  for (i in 1:length(Protein2Gene$V2)) {
    gene1 <- gene_info$gene[match(tmp1[i],gene_info$protein_id)]
    gene2 <- gene_info$gene[match(tmp2[i],gene_info$protein_id)]
    tmp1[i] <- gene1
    tmp2[i] <- gene2
    print(i)
  }
  Protein2Gene[,1] <- tmp1
  Protein2Gene[,2] <- tmp2
  colnames(Protein2Gene[,c(1,2)]) <- c("ligand","receptor")
  Protein2Gene$interaction_name <- paste0(Protein2Gene$ligand,"-",Protein2Gene$receptor)
  Protein2Gene$pathway_name <- Protein2Gene$ligand
  geneinfo <- as.data.frame(unique(c(Protein2Gene$ligand,Protein2Gene$receptor)))
  colnames(geneinfo) <- "Symbol"
  return(updateCellChatDB(
    Protein2Gene,
    gene_info = geneinfo,
    other_info = NULL,
    merged = FALSE,
    species_target = NULL
  ))
}
