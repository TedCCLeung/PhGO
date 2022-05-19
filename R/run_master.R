run_master <- function(
  small_cluster_filter = 50,
  p_adj_threshold = 1e-3,
  output_dir = "data-raw/"
){

  ## STEP 0: PROCESS INPUT CLUSTERS -----------------------------
  small_clusters <- photoperiodic_clusters %>% unlist(recursive = FALSE)
  small_clusters <- small_clusters[lengths(small_clusters) >= small_cluster_filter]

  big_clusters <- lapply(photoperiodic_clusters, function(x){unlist(x) %>% as.character()})

  dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)

  ## STEP 1: RUN GO ENRICHMENT -----------------------------

  df_small_enrich <- run_GOenrich(
    small_clusters,
    simplify_cutoff = 0.5,
    ont = "BP"
  )@compareClusterResult

  df_big_enrich <- run_GOenrich(
    big_clusters,
    simplify_cutoff = 0.5,
    ont = "BP"
  )@compareClusterResult

  utils::write.csv(df_small_enrich, file = paste0(output_dir, "GOenrich_small.csv"), row.names = FALSE)
  utils::write.csv(df_big_enrich, file = paste0(output_dir, "GOenrich_big.csv"), row.names = FALSE)

  ## STEP 2: PLOT HEATMAPS -----------------------------

  heatmap_big <- heatmap_GO(df_big_enrich, p_adj_threshold)
  grDevices::pdf(paste0(output_dir, "heatmap_GO_big.pdf"), height = 6, width = 6)
  heatmap_big %>% ComplexHeatmap::draw()
  grDevices::dev.off()

  heatmap_small <- heatmap_GO(df_small_enrich, p_adj_threshold)
  grDevices::pdf(paste0(output_dir, "heatmap_GO_small.pdf"), height = 6, width = 6)
  heatmap_small %>% ComplexHeatmap::draw()
  grDevices::dev.off()


  ## STEP 3: GSEA -----------------------------
  run_GSEA_GO(dir = output_dir)
  run_GSEA_KEGG(dir = output_dir)
}
