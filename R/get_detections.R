#' Retrieve aggregated detection data for multiple species.
#'
#' This function obtains aggregated detection data for multiple species by iterating
#' through the list of species obtained from \code{\link{lfa_get_species}}. For each
#' species, it calls \code{\link{lfa_get_detections_species}} to retrieve the
#' corresponding detection data and aggregates the results into a single data frame.
#' The resulting data frame includes columns for the species, tree detection data,
#' and the area in which the detections occurred.
#'
#' @return A data frame containing aggregated detection data for multiple species.
#'
#' @export
#' @seealso
#' \code{\link{lfa_get_species}}, \code{\link{lfa_get_detections_species}}
#'
#' @examples
#' lfa_get_detections()
#'
#' @keywords data manipulation aggregation
#'
#' @family data retrieval functions
#'
#' @examples
#' # Retrieve aggregated detection data for multiple species
#' detections_data <- lfa_get_detections()
#'
#' @export
lfa_get_detections <- function() {
  species <- lfa_get_species()
  results <- NULL
  for(specie in species){
    trees <- lfa_get_detections_species(specie)
    trees$specie <- specie
    if(is.null(results)){
      results <- trees
    } else {
      results <- dplyr::bind_rows(results, trees)
    }
  }
  results$area <- as.factor(results$area)
  results$specie <- as.factor(results$specie)
  return(results)
}
