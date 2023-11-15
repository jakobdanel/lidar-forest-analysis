
#' Initialize LFA (LiDAR forest analysis) data processing
#'
#' This function initializes the LFA data processing by reading a shapefile containing
#' spatial features of research areas, downloading the specified areas, and creating
#' tile location objects for each area.
#'
#' @param sf_file A character string specifying the path to the shapefile containing
#'   spatial features of research areas. Default is "research_areas.shp".
#'
#' @return A vector containing tile location objects.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # Initialize LFA processing with the default shapefile
#' lfa_init()
#'
#' # Initialize LFA processing with a custom shapefile
#' lfa_init("custom_areas.shp")
#' }
#'
#' @param sf_file A character string specifying the path to the shapefile containing
#'   spatial features of research areas.
#'
#' @details
#' This function reads a shapefile (`sf_file`) using the `sf` package, which should
#' contain information about research areas. It then calls the `lfa_download_areas`
#' function to download the specified areas and `lfa_create_tile_location_objects`
#' to create tile location objects based on Lidar data files in those areas. The
#' shapefile *MUST* follow the following requirements:
#' - Each geometry must be a single object of type polygon
#' - Each entry must have the following attributes:
#'   - species: A string describing the tree species of the area.
#'   - name: A string describing the location of the area.
#'
#' @examples
#' \dontrun{
#' # Example usage with the default shapefile
#' lfa_init()
#'
#' # Example usage with a custom shapefile
#' lfa_init("custom_areas.shp")
#' }
#'
#' @export
lfa_init <- function(sf_file = "research_areas.shp") {
  library(sf)
  sf_areas <- read_sf(sf_file)
  lfa_download_areas(sf_areas)
  return(lfa_create_tile_location_objects())
}
