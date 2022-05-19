run_GSEA_GO <- function(
  dir,
  terms_to_filter = c(
    "oxygen levels", "oligopeptide", "flavone", "falvonoid",
    "pyridine nucleotide metabolic process",
    "pyridine-containing", "viral", "nicotinamide nucleotide metabolic process",
    "gene silencing by RNA"
    )
){

  gseGO_SDLD <- DEI_GSEA_gene_list(cond_1 = "SD", cond_2 = "LD", NCBI_ID = FALSE) %>%
    clusterProfiler::gseGO(pvalueCutoff = 1, verbose = FALSE, minGSSize = 20, ont = "BP", keyType = "TAIR", OrgDb = org.At.tair.db::org.At.tair.db)
  gseGO_EQLD <- DEI_GSEA_gene_list(cond_1 = "EQ", cond_2 = "LD", NCBI_ID = FALSE) %>%
    clusterProfiler::gseGO(pvalueCutoff = 1, verbose = FALSE, minGSSize = 20, ont = "BP", keyType = "TAIR", OrgDb = org.At.tair.db::org.At.tair.db)
  gseGO_SDEQ <- DEI_GSEA_gene_list(cond_1 = "SD", cond_2 = "EQ", NCBI_ID = FALSE) %>%
    clusterProfiler::gseGO(pvalueCutoff = 1, verbose = FALSE, minGSSize = 20, ont = "BP", keyType = "TAIR", OrgDb = org.At.tair.db::org.At.tair.db)

  grDevices::pdf(paste0(dir, "/go_sdld.pdf"), width = 3.5, height = 2.5)
  clusterProfiler::ridgeplot(gseGO_SDLD %>% dplyr::filter(str_detect_multiple(.data$Description, terms_to_filter)),
                             showCategory = 10, core_enrichment = FALSE, orderBy = "NES") +
    ggplot2::scale_fill_steps(low = "#FF0000", high = "#0000FF", guide = ggplot2::guide_colorbar(reverse=TRUE), name = "p.adjust", limits=c(0.0, 0.8)) +
    theme_Prism()
  grDevices::dev.off()

  grDevices::pdf(paste0(dir, "/go_eqld.pdf"), width = 3.5, height = 2.5)
  clusterProfiler::ridgeplot(gseGO_EQLD %>% dplyr::filter(str_detect_multiple(.data$Description, terms_to_filter)),
                             orderBy = "NES", showCategory = 10, core_enrichment = FALSE) +
    ggplot2::scale_fill_steps(low = "#FF0000", high = "#0000FF", guide = ggplot2::guide_colorbar(reverse=TRUE), name = "p.adjust", limits=c(0.0, 0.8)) +
    theme_Prism()
  grDevices::dev.off()

  grDevices::pdf(paste0(dir, "/go_sdeq.pdf"), width = 3.5, height = 2.5)
  clusterProfiler::ridgeplot(gseGO_SDEQ %>% dplyr::filter(str_detect_multiple(.data$Description, terms_to_filter)),
                             orderBy = "NES", showCategory = 10, core_enrichment = FALSE) +
    ggplot2::scale_fill_steps(low = "#FF0000", high = "#0000FF", guide = ggplot2::guide_colorbar(reverse=TRUE), name = "p.adjust", limits=c(0.0, 0.8)) +
    theme_Prism()
  grDevices::dev.off()
}












