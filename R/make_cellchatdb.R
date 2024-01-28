#' make a custom cell chat database.
#'@description
#' make a custom cell chat database with a input node file generated from get_nodes.
#'
#' @param interaction_nodes node file generated from get_nodes.
#' @param enrich A give pathway type, such as "KEGG", or "GO", as you wish.
#'
#' @return a cell chat database.
#' @export
#'
#' @examples NA
make_cellchatdb <- function(interaction_nodes,enrich=NULL){
  geneinfo <- as.data.frame(unique(c(interaction_nodes$ligand,interaction_nodes$receptor)))
  if (is.null(enrich)){}
  else
  {
    interaction_nodes$evidence = enrich
  }
  colnames(geneinfo) <- "Symbol"
  return(CellChat::updateCellChatDB(interaction_nodes,
                          gene_info = geneinfo,
                          other_info = NULL,
                          merged = FALSE,
                          species_target = NULL
  ))
}
