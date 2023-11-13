#' Download an las file from the state NRW from a specific location
#'
#' It will download the file and save it to data/<species>/<name> with the name of the tile
#' @param species The species of the tree which is observed at this location
#' @param name The name of the area that is observed
#' @param location An sf object, which holds the location information for the area where the tile should be downloaded from.
#'
#' @return The LASCatalog object of the downloaded file
#' @export
lfa_download <- function(species, name, location) {
  library(GEDIcalibratoR)
  mytiles = intersect_tiles2download("NRW", location) |>
    download_tiles(dir = file.path( "data", species, name), what = "LAZ")
  return(mytiles)
}
