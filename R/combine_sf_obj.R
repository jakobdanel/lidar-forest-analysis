#' Combine Spatial Feature Objects from Multiple GeoPackage Files
#'
#' This function reads spatial feature objects (sf) from multiple GeoPackage files and combines them into a single sf object.
#' Each GeoPackage file is assumed to contain neighbor information for a specific detection area, and the resulting sf object
#' includes additional columns indicating the corresponding area and species information.
#'
#' @param paths A character vector containing file paths to GeoPackage files with neighbor information.
#' @param area_infos A data frame or list containing information about the corresponding detection areas, including "area" and "specie" columns.
#' @return A combined sf object with additional columns for area and specie information.
#' @export
#'
#' @examples
#' # Assuming paths and area_infos are defined
#' combined_sf <- lfa_combine_sf_obj(paths, area_infos)
#'
#' # Print the combined sf object
#' print(combined_sf)
#'
#'@export
lfa_combine_sf_obj <- function(paths, area_infos) {
  sf_obj <- sf::st_read(paths[1])
  sf_obj$area = area_infos$area[1]
  sf_obj$specie = area_infos$specie[1]
  for (i in 2:length(paths)) {
    extend <- sf::st_read(paths[i])
    extend$area = area_infos$area[i]
    extend$specie = area_infos$specie[i]
    sf_obj <- dplyr::bind_rows(sf_obj, extend)
  }
  return(sf_obj)
}
