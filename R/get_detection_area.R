#' Get Detection for an area
#'
#' Retrieves the tree detection information for a specified species and tile.
#'
#' @param species A character string specifying the target species.
#' @param name A character string specifying the name of the tile.
#'
#' @return A Simple Features (SF) data frame containing tree detection information for the specified species and tile.
#'
#' @details This function reads tree detection data from geopackage files within the specified tile location for a given species. It then combines the data into a single SF data frame and returns it. The function assumes that the tree detection files follow a naming convention with the pattern "_detection.gpkg".
#'
#' @export
#'
#' @examples
#' # Retrieve tree detection data for species "example_species" in tile "example_tile"
#' trees_data <- lfa_get_detection_tile_location("example_species", "example_tile")
#'
#' @seealso \code{\link{get_tile_dir}}
#'
#'
#' @keywords spatial
#'
#' @references
#' This function is part of the LiDAR Forest Analysis (LFA) package.
#'
#' @examples
#' # Example usage:
#' trees_data <- lfa_get_detection_tile_location("example_species", "example_tile")
#'
#' # No trees found scenario:
#' empty_data <- lfa_get_detection_tile_location("nonexistent_species", "nonexistent_tile")
#' # The result will be an empty data frame if no trees are found for the specified species and tile.
#'
#' # Error handling:
#' # In case of invalid inputs, the function may throw errors. Ensure correct species and tile names are provided.
#'
lfa_get_detection_area <- function(species, name) {
  tile_location = new(
    "tile_location",
    species = species,
    name = name,
    tile_name = "egal"
  )

  tile_dir <- get_tile_dir(tile_location)
  trees = NULL
  files <-
    list.files(tile_dir, pattern = "_detection.gpkg", full.names = T)
  for (file in files) {
    if (is.null(trees)) {
      trees <- sf::read_sf(file)
    } else{
      trees <- dplyr::bind_rows(trees, sf::read_sf(file))
    }
  }
  return(trees)
}
