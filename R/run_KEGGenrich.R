#' Perform KEGG term enrichment
#'
#' @importFrom magrittr %>%
#'
#' @param geneList A list of gene identifiers in TAIR gene identifiers
#' @param simplify_cutoff Numeric. Similarity cutoff for simplifying GO terms
#'
#' @return Named numeric vector


run_KEGGenrich <- function(
  geneList
){

  result <- clusterProfiler::compareCluster(
    geneCluster = geneList,
    fun = "enrichKEGG",
    organism = "ath",
    pvalueCutoff = 0.5,
    qvalueCutoff = 1.0,
    minGSSize = 10,
    maxGSSize = 500,
    pAdjustMethod = "BH"
  )
  return(result)
}
