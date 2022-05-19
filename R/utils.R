addLeadingZeros <- function(
  num_vec
){
  digit_number <- floor(max(log10(num_vec)+1))
  return(stringr::str_pad(as.character(num_vec), digit_number, pad = "0"))
}

str_detect_multiple <- function(
  character_vector,
  patterns_to_remove,
  negate = TRUE
){

  vecs <- lapply(patterns_to_remove, function(x){
    return(stringr::str_detect(character_vector, pattern = x, negate = negate))
  }) %>% as.data.frame()

  return(apply(vecs, 1, all))
}

sort_double_abc <- function(x, split = "\\."){

  x1 <- strsplit(x, split = split) %>% sapply(utils::head, 1)
  x2 <- strsplit(x, split = split) %>% sapply(magrittr::extract, 2)

  final <- lapply(unique(x1), function(y){
    sub_x <- x[startsWith(x1, y)]
    sub_x2 <- strsplit(sub_x, split = split) %>% sapply(magrittr::extract, 2)
    return(sub_x[order(nchar(sub_x2, allowNA = TRUE, keepNA = FALSE))])
  }) %>% unlist()

  return(final)
}


#character_vector <- c("ABC", "CDE", "EFG", "XYZ")
#patterns_to_remove <- c("E", "X")

