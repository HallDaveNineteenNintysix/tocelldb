#' Download a gtf file from ncbi.
#'@description
#' Download a gtf file from ncbi and get gene & protein infomations.
#'
#' @param No.assembly NCBI assembly number, such as "GCF_000001405.40".
#'
#' @return gene & protein informations.
#' @export
#'
#' @examples NA
down_gtf <- function(No.assembly){
  node_url <- c("https://api.ncbi.nlm.nih.gov/datasets/v2alpha/genome/accession/",No.assembly,"/download?include_annotation_type=GENOME_GTF")
  node_url <- paste(node_url,sep = "",collapse = "")
  filename <- paste(No.assembly,".zip",sep = "",collapse = "")
  utils::download.file(node_url,destfile = filename)
  gtf <- paste("ncbi_dataset/data/",No.assembly,"/genomic.gtf",sep = "",collapse = "")
  utils::unzip(filename,gtf)
  gtf <- rtracklayer::import('genomic.gtf')
  gtf <- as.data.frame(gtf)
  Protein <- gtf[,c("protein_id","gene")]
  Protein <- Protein[is.na(Protein$protein_id)==F,]
  return(Protein)
}
