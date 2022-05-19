#' Perform GO term enrichment
#'
#' @importFrom magrittr %>%
#'
#' @param geneList A list of gene identifiers in TAIR gene identifiers
#' @param simplify_cutoff Numeric. Similarity cutoff for simplifying GO terms
#' @param ont Character. Ontology.
#'
#' @return Named numeric vector


run_GOenrich <- function(
  geneList,
  simplify_cutoff = 0.5,
  ont = "BP"
){

  result <- clusterProfiler::compareCluster(
    geneCluster = geneList,
    OrgDb = org.At.tair.db::org.At.tair.db,
    fun = "enrichGO",
    ont = ont,
    pvalueCutoff = 0.5,
    qvalueCutoff = 1.0,
    minGSSize = 10,
    maxGSSize = 500,
    keyType = "TAIR",
    pAdjustMethod = "BH"
  )

  simplified <- clusterProfiler::simplify(result, cutoff = simplify_cutoff)
  return(simplified)
}
