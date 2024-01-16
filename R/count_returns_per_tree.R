#' Count returns per tree for a given lidR catalog.
#'
#' This function takes a lidR catalog as input and counts the returns per tree.
#' It uses the lidR package to read LAS files from the catalog and performs the counting
#' operation on each tree. The result is a data frame containing the counts of returns
#' for each unique tree ID within the lidR catalog.
#'
#' @param ctg A lidR catalog object containing LAS files to be processed.
#'
#' @return A data frame with columns for tree ID and the corresponding count of returns.
#'
#' @seealso
#' \code{\link{lidR::readLAS}}, \code{\link{lidR::is.empty}},
#' \code{\link{base::table}}, \code{\link{dplyr::bind_rows}}
#'
#' @examples
#' # Count returns per tree for a lidR catalog
#' ctg <- lfa_read_area_as_catalog("SpeciesA", "Area1")
#' returns_counts_per_tree <- lfa_count_returns_per_tree(ctg)
#'
#' @keywords lidR lidar tree returns counting
#'
#' @export
lfa_count_returns_per_tree <- function(ctg) {
  count <- function(chunk) {
    if (lidR::is.empty(chunk)) {
      return(NULL)
    } else {
      return(chunk$treeID |> as.factor() |> base::table() |> as.data.frame())
    }
  }
  results <- NULL
  for (file in ctg$filename) {
    las <- lidR::readLAS(file)
    t <- count(las)
    if (is.null(results)) {
      results <- t
    } else{
      results <- dplyr::bind_rows(results, t)
    }
  }
  return(results)
}
