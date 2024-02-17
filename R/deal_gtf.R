#' Load a gtf file.
#'@description
#' Load a gtf file from ncbi and get gene & protein infomations.
#'
#' @param gtf_file The directory of a input gtf file.
#' @param protein Get protein or gene info.
#'
#' @return gene & protein informations.
#' @export
#'
#' @examples NA
deal_gtf <- function(gtf_file,protein=T){
  gtf <- as.data.frame(rtracklayer::import(gtf_file))
  if (protein){
  gtf <- gtf[is.na(gtf$protein_id)==F,c("protein_id","gene","db_xref")]
  }
  else {
    gtf <- gtf[is.na(gtf$db_xref)==F,c("gene","db_xref")]
    gtf <- dplyr::mutate(gtf, db_xref = stringr::str_extract(gtf$db_xref, "\\d{2,9}"))
  }
  return(gtf)
}
