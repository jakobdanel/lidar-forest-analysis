#' Download areas based on spatial features
#'
#' This function initiates the data structure and downloads areas based on spatial features.
#'
#' @param sf_areas Spatial features representing areas to be downloaded.
#'   It must include columns like "species" "name"
#'   See details for more information.
#'
#' @return None
#'
#'
#' @examples
#' \dontrun{
#' lfa_download_areas(sf_areas)
#' }
#'
#'
#' @details
#' The input data frame, `sf_areas`, must have the following columns:
#' - "species": The species associated with the area.
#' - "name": The name of the area.
#'
#' The function uses the `lfa_init_data_structure` function to set up the data structure
#' and then iterates through the rows of `sf_areas` to download each specified area.
#'
#' @examples
#' \dontrun{
#' # Example spatial features data frame
#' sf_areas <- data.frame(
#'   species = c("SpeciesA", "SpeciesB"),
#'   name = c("Area1", "Area2"),
#'   # Must include also other attributes specialized to sf objects
#'   # such as geometry, for processing of the download
#' )
#'
#' lfa_download_areas(sf_areas)
#' }
#' @author Jakob Danel
#' @export
lfa_download_areas <- function(sf_areas){
  lfa_init_data_structure(sf_areas)
  for (i in 1:length(sf_areas$id)) {
    lfa_download(sf_areas$species[i], sf_areas$name[i], sf_areas[i, ])
  }
}
