run_GSEA_KEGG <- function(
  dir = "./"
){

  gseKEGG_SDLD <- DEI_GSEA_gene_list(cond_1 = "SD", cond_2 = "LD", NCBI_ID = FALSE) %>%
    clusterProfiler::gseKEGG(organism = "ath", pvalueCutoff = 1, verbose = FALSE, minGSSize = 10)
  gseKEGG_EQLD <- DEI_GSEA_gene_list(cond_1 = "EQ", cond_2 = "LD", NCBI_ID = FALSE) %>%
    clusterProfiler::gseKEGG(organism = "ath", pvalueCutoff = 1, verbose = FALSE, minGSSize = 10)
  gseKEGG_SDEQ <- DEI_GSEA_gene_list(cond_1 = "SD", cond_2 = "EQ", NCBI_ID = FALSE) %>%
    clusterProfiler::gseKEGG(organism = "ath", pvalueCutoff = 1, verbose = FALSE, minGSSize = 10)

  grDevices::pdf(paste0(dir, "kegg_sdld.pdf"), width = 3.5, height = 2.5)
  clusterProfiler::ridgeplot(gseKEGG_SDLD, showCategory = 8, core_enrichment = FALSE, orderBy = "NES") +
    ggplot2::scale_fill_steps(low = "#FF0000", high = "#0000FF", guide = ggplot2::guide_colorbar(reverse=TRUE), name = "p.adjust", limits=c(0.0, 0.8)) +
    theme_Prism()
  grDevices::dev.off()

  grDevices::pdf(paste0(dir, "kegg_eqld.pdf"), width = 3.5, height = 2.5)
  clusterProfiler::ridgeplot(gseKEGG_EQLD, orderBy = "NES", showCategory = 10, core_enrichment = FALSE) +
    ggplot2::scale_fill_steps(low = "#FF0000", high = "#0000FF", guide = ggplot2::guide_colorbar(reverse=TRUE), name = "p.adjust", limits=c(0.0, 0.8)) +
    theme_Prism()
  grDevices::dev.off()

  grDevices::pdf(paste0(dir, "kegg_sdeq.pdf"), width = 3.5, height = 2.5)
  clusterProfiler::ridgeplot(gseKEGG_SDEQ, orderBy = "NES", showCategory = 10, core_enrichment = FALSE) +
    ggplot2::scale_fill_steps(low = "#FF0000", high = "#0000FF", guide = ggplot2::guide_colorbar(reverse=TRUE), name = "p.adjust", limits=c(0.0, 0.8)) +
    theme_Prism()
  grDevices::dev.off()
}












