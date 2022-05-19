#' Make heatmap for GO enrichment
#'
#' @importFrom magrittr %>%
#'
#' @param df A list of gene identifiers in TAIR gene identifiers
#' @param p_adj_threshold Numeric. Filter for adjusted p value
#'
#' @return Named numeric vector


heatmap_GO <- function(
  df,
  p_adj_threshold
){

  ComplexHeatmap::ht_opt(
    legend_title_gp = grid::gpar(fontsize = 7, fontface = "bold", base_family="Arial"),
    legend_labels_gp = grid::gpar(fontsize = 7, fontface = "bold", base_family="Arial"),
    heatmap_column_names_gp = grid::gpar(fontsize = 7, fontface = "bold", base_family="Arial"),
    heatmap_column_title_gp = grid::gpar(fontsize = 7, fontface = "bold", base_family="Arial"),
    heatmap_row_title_gp = grid::gpar(fontsize = 7, fontface = "bold", base_family="Arial"),
    heatmap_row_names_gp = grid::gpar(fontsize = 7, fontface = "bold", base_family="Arial"),
    message = FALSE
  )



  df$name <- paste0(ifelse(startsWith(df$ID, "GO"), "-", "*"), " ", df$Description)
  sig_terms <- df[df$p.adjust < p_adj_threshold, c("ID")]


  df_dummy <- data.frame(
    Cluster = df$Cluster %>% unique(),
    name = rep("dummy", times = length(df$Cluster %>% unique())),
    p.adjust = rep(NA, times = length(df$Cluster %>% unique()))
  )

  df_sig <- df[df$ID %in% sig_terms, c("Cluster", "name", "p.adjust")]

  df_p <- rbind(df_sig, df_dummy) %>%
    tidyr::pivot_wider(names_from = "Cluster", values_from = "p.adjust", values_fill = 1) %>%
    tibble::column_to_rownames(var = "name") %>%
    as.matrix()

  missing_clusters <- unique(df$Cluster)[!unique(df$Cluster) %in% df_sig$Cluster] %>% as.character()
  df_p[, missing_clusters] <- NA

  input_matrix <- log(df_p, 10)*-1
  input_matrix <- input_matrix[rownames(input_matrix) != "dummy", sort(colnames(input_matrix)) %>% sort_double_abc()]
  column_split_vec <- strsplit(colnames(input_matrix), split = "\\.") %>% sapply(magrittr::extract2, 1)
  colnames(input_matrix) <- strsplit(colnames(input_matrix), split = "\\.") %>% sapply(utils::tail, 1)


  ht <- ComplexHeatmap::Heatmap(
    input_matrix,
    col = circlize::colorRamp2(c(0, 5), c("#EEEEEE", "#FF0000")),
    cluster_columns = FALSE,
    column_split = column_split_vec,
    heatmap_legend_param = list(direction = "horizontal"),
    na_col = "#EEEEEE",
    show_row_dend = FALSE,
    rect_gp = grid::gpar(col= "white")
  )
  #ComplexHeatmap::draw(ht, heatmap_legend_side = "bottom")
  return(ht)
}
