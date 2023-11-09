source("R/tile_location.R")

download <- function(species, name, location) {
  library(GEDIcalibratoR)
  mytiles = intersect_tiles2download("NRW", location) |>
    download_tiles(dir = file.path("..", "data", species, name), what = "LAZ")
  return(mytiles)
}
