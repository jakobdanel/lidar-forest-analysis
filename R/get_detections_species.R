#' Retrieve detections for a specific species.
#'
#' This function retrieves detection data for a given species from multiple areas.
#'
#' @param species A character string specifying the target species.
#'
#' @return A data frame containing detection information for the specified species in different areas.
#'
#' @details The function looks for detection data in the "data" directory for the specified species.
#' It then iterates through each subdirectory (representing different areas) and consolidates the
#' detection data into a single data frame.
#'
#' @examples
#' # Example usage:
#' detections_data <- lfa_get_detections_species("example_species")
#'
#'@export
lfa_get_detections_species <- function(species) {
  dir_path <- file.path(getwd(), "data", species)
  areas <- list.dirs(path = dir_path,
                     full.names = FALSE,
                     recursive = FALSE)
  results <- NULL
  for (area in areas) {
    trees <- lfa_get_detection_area(species, area)
    trees$area <- area
    if (is.null(results)) {
      results <- trees
    } else {
      results <- dplyr::bind_rows(results, trees)
    }
  }
  return(results)
}
