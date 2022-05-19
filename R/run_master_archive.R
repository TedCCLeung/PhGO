# if (FALSE){
#
#   out_path <- "/Users/TedCCLeung/Documents/Projects/Photoperiod/2_analysis/2_pipeline/PhotoperiodGO/set2/"
#
#   small_cluster_filter <- 40
#   p_adj_threshold = 1e-3
#
#   PhotoperiodicGO_dir <- "/Users/TedCCLeung/Documents/Projects/Packages/PhotoperiodGO/"
#   list.files(paste0(PhotoperiodicGO_dir, "R/"), full.names = TRUE) %>% lapply(source) %>% invisible()
#   list.files(paste0(PhotoperiodicGO_dir, "data/"), full.names = TRUE) %>% lapply(load) %>% invisible()
#
#   cluster_file <- "/Users/TedCCLeung/Documents/Projects/Photoperiod/2_analysis/2_pipeline/PhotoperiodClusters/hybrid/clusters.tsv"
#   photoperiodic_clusters <- cluster_table_to_list(cluster_file)
#   redundant_clusters <- photoperiodic_clusters[lengths(photoperiodic_clusters) == 1] %>% unlist(recursive = FALSE) %>% names()
#
#   small_clusters <- photoperiodic_clusters %>% unlist(recursive = FALSE)
#   small_clusters <- small_clusters[lengths(small_clusters) >= small_cluster_filter]
#   big_clusters <- lapply(photoperiodic_clusters, function(x){unlist(x) %>% as.character()})
#
#   all_clusters <- c(big_clusters, small_clusters)
#   all_clusters <- all_clusters[order(names(all_clusters))]
#   all_clusters <- all_clusters[!names(all_clusters) %in% redundant_clusters]
#
#
#   ## STEP 2: PLOT HEATMAPS -----------------------------
#
#   enrich_g <- run_GOenrich(
#     geneList = all_clusters,
#     simplify_cutoff = 0.5,
#     ont = "BP"
#   )
#
#   enrich_k <- run_KEGGenrich(
#     geneList = all_clusters
#   )
#
#   df_enrich <- rbind(enrich_g@compareClusterResult, enrich_k@compareClusterResult)
#   utils::write.table(df_enrich, file = paste0(out_path, "enrich_result.tsv"), sep = "\t", quote = FALSE, row.names = FALSE)
#
#   #df_enrich <- utils::read.table("/Users/TedCCLeung/Documents/Projects/Photoperiod/2_analysis/2_pipeline/PhotoperiodGO/set2/enrich_result.tsv", sep = "\t", quote = "\"", header = TRUE)
#
#   df_enrich <- df_enrich[df_enrich$Count > 1, ]
#   terms_to_remove <- c("rhythmic process", "oxygen level", "ribosomal large subunit assembly",
#                        "complex subunity organ", "peptidyl−cysteine", "rRNA metabolic", "deoxyribose phosphate",
#                        "abiotic stimulus", "ncRNA processing", "pentose", "carbon fixation",
#                        "signal transduction", "biogenic amine",
#                        "deoxyribonucleotide metabolic", "oxidative phosphorylation",
#                        "protein nitrosylation",
#                        "deoxyribonucleotide", "TP metabolic process", "rRNA", "response to red light",
#                        "cellular amine", "protein import into chloroplast stroma",
#                        "ribosomal large subunit biogenesis",
#                        "environmental stimulus", "translational elongation",
#                        "non-membrane-bounded",
#                        "antenna", 'Oxocarboxylic', "response to water", "acid chemical", "plastid",
#                        "precursor", "amino acid catabolic",
#                        "Glyoxylate", "GO:0015979", "GO:0009644", "GO:0042254", "GO:0002181", "GO:0034976",
#                        "GO:0009644", "ath01200", "GO:0015994", "splicing")
#
#   df_enrich <- df_enrich[str_detect_multiple(df_enrich$Description, terms_to_remove, negate = TRUE), ]
#   df_enrich <- df_enrich[str_detect_multiple(df_enrich$ID, terms_to_remove, negate = TRUE), ]
#
#   groups_to_remove <- c("03.3AG", "03.3AA", "02.2C", "06.6A", "06.6D", "04.4I", "04.4Q",
#                         "11.11B", "11.11I", "11.11AC")
#   df_enrich <- df_enrich[!(df_enrich$Cluster %in% groups_to_remove), ]
#
#   heatmap <- heatmap_GO(df_enrich, p_adj_threshold = p_adj_threshold)
#   grDevices::pdf(paste0(out_path, "heatmap.pdf"), height = 4.0, width = 8)
#   heatmap %>% ComplexHeatmap::draw(heatmap_legend_side = "bottom")
#   grDevices::dev.off()
# }
