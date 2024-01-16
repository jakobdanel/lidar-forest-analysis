#' Count tree returns for all species and areas, returning a consolidated data frame.
#'
#' This function iterates through all species and areas obtained from the function
#' \code{\link{lfa_get_all_areas}}. For each combination of species and area, it reads
#' the corresponding area as a catalog, counts the returns per tree using
#' \code{\link{lfa_count_returns_per_tree}}, and consolidates the results into a data frame.
#' The resulting data frame includes columns for the species, area, and return counts per tree.
#'
#' @return A data frame with columns for species, area, and return counts per tree.
#'
#' @seealso
#' \code{\link{lfa_get_all_areas}}, \code{\link{lfa_read_area_as_catalog}},
#' \code{\link{lfa_count_returns_per_tree}}
#'
#' @examples
#' # Count tree returns for all species and areas
#' returns_counts <- lfa_count_returns_all_areas()
#'
#' @keywords data manipulation tree returns counting
#'
#' @export
lfa_count_returns_all_areas <- function() {
  areas <- lfa_get_all_areas()
  df <- NULL
  for (i in 1:nrow(areas)) {
    counts <-
      lfa_read_area_as_catalog(areas[i,]$specie, areas[i,]$area) |> lfa_count_returns_per_tree()
    counts$specie <- areas[i,]$specie
    counts$area <- areas[i,]$area
    if (is.null(df)) {
      df <- counts
    } else{
      df <- dplyr::bind_rows(df, counts)
    }
  }
  df$specie <- as.factor(df$specie)
  df$area <- as.factor(df$area)
  return(df)
}
