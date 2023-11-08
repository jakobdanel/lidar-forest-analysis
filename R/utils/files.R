



is_tile_existing <- function(species, name, tile_name) {
  return(get_tiles_path(species, name, tile_name) |> file.exists())
}

get_tiles_path <- function(species, name, tile_name) {
  return(getwd() |> paste0("/", "data" |> file.path(
    species, name, tile_name |> paste0(".laz")
  )))
}

get_retile_dir <- function(species, name, tile_name) {
  return(getwd() |> paste0("/", "data" |> file.path(species, name, tile_name |> paste0("/"))))
}
