#' make a custom cell chat database.
#'@description
#' make a custom cell chat database with a input node file generated from get_nodes.
#'
#' @param interaction_nodes nodes file generated from get_nodes.
#' @param enrich A given pathway type, such as "KEGG：map04216", or "GO", as you wish.
#' @param annotation A given interaction type, one of "Secreted Signaling", "ECM-Recptor", "Cell-Cell Contact", "Non-protein Signaling".
#'
#' @return a cell chat database.
#' @export
#'
#' @examples NA
make_cellchatdb <- function(interaction_nodes,enrich=NULL,annotation=NULL){
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
  return(CellChat::updateCellChatDB(interaction_nodes,
                          gene_info = geneinfo,
                          other_info = NULL,
                          merged = FALSE,
                          species_target = NULL
  ))
}
