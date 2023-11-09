source("R/tile_location.R")



get_tiles_path <- function(tile_location) {
  return(getwd() |> paste0(
    "/",
    "data" |> file.path(
      tile_location@species,
      tile_location@name,
      tile_location@tile_name |> paste0(".laz")
    )
  ))
}


get_retile_dir <- function(tile_location) {
  return(getwd() |> paste0(
    "/",
    "data" |> file.path(
      tile_location@species,
      tile_location@name,
      tile_location@tile_name |> paste0("/")
    )
  ))
}


is_tile_existing <- function(tile_location) {
  return(get_tiles_path(tile_location) |> file.exists())
}
