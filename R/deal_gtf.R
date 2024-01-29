#' Load a gtf file.
#'@description
#' Load a gtf file from ncbi and get gene & protein infomations.
#'
#' @param gtf_file The directory of a input gtf file.
#'
#' @return gene & protein informations.
#' @export
#'
#' @examples NA
deal_gtf <- function(gtf_file){
  gtf <- rtracklayer::import(gtf_file)
  gtf <- as.data.frame(gtf)
  Protein <- gtf[,c("protein_id","gene")]
  Protein <- Protein[is.na(Protein$protein_id)==F,]
  return(Protein)
}
