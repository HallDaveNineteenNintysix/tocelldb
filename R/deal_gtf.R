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
  gtf <- as.data.frame(rtracklayer::import(gtf_file))
  gtf <- gtf[is.na(gtf$protein_id)==F,c("protein_id","gene")]
  return(gtf)
}
