#' @export
get_tile_dir <- function(tile_location) {
  return(paste0(
    getwd(),
    "/data/",
    file.path(
      tile_location@species,
      tile_location@name
    ) |> paste0("/")
  ))
}
