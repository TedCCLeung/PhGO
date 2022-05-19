#' Retrieve a named numeric vector of the relative daily expression integral in log2
#' @importFrom magrittr %>%
#' @param cond_1 Either "EQ", "LD", or "SD"
#' @param cond_2 Either "EQ", "LD", or "SD"
#' @param threshold Numeric. Filter for total expression level
#' @param NCBI_ID Logical. Whether the names should be converted from TAIR ID to NCBI ID
#'
#' @return Named numeric vector

DEI_GSEA_gene_list <- function(
  cond_1 = "SD",
  cond_2 = "LD",
  threshold = 0,
  NCBI_ID = TRUE
){

  ## Calculate log2 fold change of the two conditions, i.e. rDEI ----------
  cond_1_vector <- DEI_table[, paste0("DEI_", cond_1)]; names(cond_1_vector) <- DEI_table[, "ID"]
  cond_2_vector <- DEI_table[, paste0("DEI_", cond_2)]; names(cond_2_vector) <- DEI_table[, "ID"]
  logFC_vector <- log2(cond_1_vector/cond_2_vector)

  ## Filtering ----------
  expression_filter <- rowSums(DEI_table[, 2:4]) > threshold    ## Filter out low expression genes
  identifier_filter <- startsWith(DEI_table$ID, "AT")           ## Filter out spike-ins
  na_filter <- !is.na(logFC_vector)
  inf_filter <- !is.infinite(logFC_vector)

  AND_ <- function(...){Reduce("&", list(...))}

  final_filter <- AND_(expression_filter, identifier_filter, na_filter, inf_filter)
  final_vector <- sort(logFC_vector[final_filter], decreasing = TRUE)

  if (NCBI_ID){
    NCBI_ID_out <- ID_table[match(names(final_vector), ID_table$TAIR), "NCBI"]
    final_vector <- final_vector[!is.na(NCBI_ID_out)]
    NCBI_ID_out <- NCBI_ID_out[!is.na(NCBI_ID_out)]
    names(final_vector) <- NCBI_ID_out
  }

  return(final_vector)
}
