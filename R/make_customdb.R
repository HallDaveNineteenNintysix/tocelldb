#' make a custom cell chat database.
#'@description
#'make a custom cell chat database with a input node file downloaded from STRINGdb.
#'
#' @param interaction_nodes nodes file downloaded from STRINGdb.
#' @param gene_info gene & protein infomations generated from down_gtf() if you need to transform protein_id to gene.
#' @param enrich A given pathway type, such as "KEGG：map04216".
#' @param annotation A given interaction type, one of "Secreted Signaling", "ECM-Recptor", "Cell-Cell Contact", "Non-protein Signaling".
#'
#' @return a cell chat database.
#' @export
#'
#' @examples NA
make_customdb <- function(interaction_nodes,gene_info=NULL,enrich=NULL,annotation=NULL){
  if (is.null(gene_info)){
    interaction_nodes <- interaction_nodes[,c(1,2)]
    colnames(interaction_nodes) <- c("ligand","receptor")
    interaction_nodes$interaction_name <- paste0(interaction_nodes$ligand,"-",interaction_nodes$receptor)
    interaction_nodes$pathway_name <- interaction_nodes$ligand
    geneinfo <- as.data.frame(unique(c(interaction_nodes$ligand,interaction_nodes$receptor)))
    if (is.null(enrich)){}
    else
    {
      interaction_nodes$evidence = enrich
    }
    if (is.null(annotation)){}
    else
    {
      interaction_nodes$annotation <- annotation
    }
    colnames(geneinfo) <- "Symbol"
  }
  else {
    interaction_nodes <- utils::read.csv(interaction_nodes,sep="\t")[,c(1,2)]
    colnames(interaction_nodes) <- c("ligand","receptor")
    interaction_nodes <-
      dplyr::mutate(interaction_nodes, ligand = gene_info$gene[match(interaction_nodes$ligand,gene_info$protein_id)])
    interaction_nodes <-
      dplyr::mutate(interaction_nodes, receptor = gene_info$gene[match(interaction_nodes$receptor,gene_info$protein_id)])
    interaction_nodes$interaction_name <- paste0(interaction_nodes$ligand,"-",interaction_nodes$receptor)
    interaction_nodes$pathway_name <- interaction_nodes$ligand
    geneinfo <- as.data.frame(unique(c(interaction_nodes$ligand,interaction_nodes$receptor)))
    colnames(geneinfo) <- "Symbol"
    if (is.null(enrich)){}
    else
    {
      interaction_nodes$evidence <- enrich
    }
    if (is.null(annotation)){}
    else
    {
      interaction_nodes$annotation <- annotation
    }
  }
  return(CellChat::updateCellChatDB(
    interaction_nodes,
    gene_info = geneinfo,
    other_info = NULL,
    merged = FALSE,
    species_target = NULL
  ))
}
