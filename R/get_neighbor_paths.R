#' Get Paths to Neighbor GeoPackage Files
#'
#' This function retrieves the file paths to GeoPackage files containing neighbor information for each detection area.
#' The GeoPackage files are assumed to be named "neighbours.gpkg" and organized in a directory structure under the "data" folder.
#'
#' @return A character vector containing file paths to GeoPackage files for each detection area's neighbors.
#' @export
#'
#' @examples
#' # Get paths to neighbor GeoPackage files for all areas
#' paths <- lfa_get_neighbor_paths()
#'
#' # Print the obtained file paths
#' print(paths)
#'@export
lfa_get_neighbor_paths <- function() {
  all_areas <- lfa::lfa_get_all_areas()
  return(file.path(
    getwd(),
    "data",
    all_areas$specie,
    all_areas$area,
    "neighbours.gpkg"
  ))
}
