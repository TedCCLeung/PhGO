# Set up package -----------------------------------
# usethis::use_git()
# usethis::use_github()
# usethis::create_github_token()
# usethis::use_mit_license()

# Data manipulation -----------------------------------
# usethis::use_package("rlang")
# usethis::use_package("utils")
# usethis::use_package("circlize")
# usethis::use_package("extrafont")


# Bioconductor -----------------------------------
# usethis::use_package("org.At.tair.db")
# usethis::use_package("ComplexHeatmap")

# Tidyverse -----------------------------------
# usethis::use_package("stringr", min_version = "1.4.0")
# usethis::use_package("magrittr", min_version = "2.0.1")
# usethis::use_package("dplyr", min_version = "1.0.7")
# usethis::use_package("tibble", type = "Suggests")
# usethis::use_package("purrr", type = "Suggests")
# usethis::use_package("tidyr", min_version = "1.1.4")
# usethis::use_package("ggplot2", min_version = "3.3.5")
# usethis::use_package("readr", type = "Suggests")
# usethis::use_package("roxygen2"); usethis::use_pipe(export = TRUE)
# usethis::use_package("clusterProfiler", min_version = "3.14.3")

# Set up NAMESPACE and install -----------------------------------
# devtools::document()
# devtools::load_all()
# devtools::check()
# devtools::install()

# For checking packages needed -----------------------------------

# TAIR_genes <- AnnotationDbi::mappedkeys(org.At.tair.db::org.At.tairENTREZID)
# mapping <- as.list(org.At.tair.db::org.At.tairENTREZID[TAIR_genes])
# ID_table <- data.frame(TAIR = names(mapping), NCBI = as.character(mapping))
# usethis::use_data(ID_table)
#
# KEGG_pathways <- AnnotationDbi::mappedkeys(org.At.tair.db::org.At.tairPATH2TAIR)
# mapping <- as.list(org.At.tair.db::org.At.tairPATH2TAIR[KEGG_pathways])
# ID_table <- data.frame(KEGG = rep(names(mapping), times = lengths(mapping)), TAIR = as.character(unlist(mapping)))
#
# TAIR_IDS <- AnnotationDbi::mappedkeys(org.At.tair.db::org.At.tairSYMBOL)
# name_mapping <- as.list(org.At.tair.db::org.At.tairSYMBOL[TAIR_IDS]) %>% lapply(paste0, collapse = "; ")
# name_table <- data.frame(TAIR = rep(names(name_mapping), times = lengths(name_mapping)), SYMBOL = as.character(unlist(name_mapping)))
#
# final <- dplyr::full_join(ID_table, name_table, by = "TAIR")
# write.csv(final, file = "fina.csv", row.names = FALSE)


# photoperiodic_clusters <- cluster_table_to_list("/Users/TedCCLeung/Documents/Projects/Photoperiod/4_clustering/hybrid/clusters.tsv")
# usethis::use_data(photoperiodic_clusters)
