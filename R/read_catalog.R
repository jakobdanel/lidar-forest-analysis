source("./R/utils/files.R")
source("./R/tile_location.R")

read_catalog <- function(tile_location) {
  library(lidR)
  return(
    get_retile_dir(
      tile_location@species,
      tile_location@name,
      tile_location@tile_name
    ) |>
      list.files(full.names = T) |>
      readLAScatalog()
  )
}
