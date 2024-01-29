#' Get interactions nodes from STRINGdb.
#'
#' @param identifiers A character vector of required parameter for multiple items, e.g. "TP53", c("TP53", "CKD2").
#' @param species NCBI taxon identifiers (e.g. Human is 9606, see: STRING organisms).
#' @param required_score threshold of significance to include an interaction, a number between 0 and 1000 (default depends on the network).
#' @param network_type network type: functional (default), physical.
#' @param add_nodes adds a number of proteins with to the network based on their confidence score.
#' @param show_query_node_labels when available use submitted names in the preferredName column when (0 or 1) (default:0).
#' @param caller_identity your identifier for us.
#' @param partners TRUE or FALSE(default), default retrieves only the interactions between the set of input proteins and between their closest interaction neighborhood (if add_nodes parameters is specified), interaction_partners API method provides the interactions between your set of proteins and all the other STRING proteins.
#' @param limit 10 by default while partners set to TRUE. the number of interaction partners retrieved per protein (most confident interactions come first)
#'
#' @return STRINGdb interaction tsv files.
#' @export
#'
#' @examples get_nodes(c("TP53","CDK2"),species=9606)
get_nodes <- function(identifiers,species=9606,partners=FALSE,limit=10,required_score=400,network_type="functional",show_query_node_labels=0,add_nodes=10,caller_identity="Anonymous"){
  if(length(identifiers)>1){
    gene_identity <- paste(identifiers,sep="",collapse = "%0d")
  }
  else{
    gene_identity=identifiers
  }
  if (partners){
  node_url <- c("https://string-db.org/api/tsv/interaction_partners?identifiers=",gene_identity,"&species=",species,
                "&required_score=",required_score,"&network_type=",network_type,"&caller_identity=",caller_identity,
                "&limit=",limit)
  }
  else {
    node_url <- c("https://string-db.org/api/tsv/network?identifiers=",gene_identity,"&species=",species,
                  "&required_score=",required_score,"&network_type=",network_type,"&add_nodes=",add_nodes,
                  "&show_query_node_labels=",show_query_node_labels,"&caller_identity=",caller_identity)
  }
  node_url <- paste(node_url,sep = "",collapse = "")
  utils::download.file(node_url,destfile = "nodes.tsv")
  node_file <- utils::read.csv("nodes.tsv",sep = "\t")[,c(3,4)]
  node_file <- node_file[duplicated(node_file),]
  colnames(node_file) <- c("ligand","receptor")
  node_file$interaction_name <- paste0(node_file$ligand,"-",node_file$receptor)
  node_file$pathway_name <- node_file$ligand
  return(node_file)
}
