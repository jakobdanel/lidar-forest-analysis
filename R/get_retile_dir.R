#' @export
lfa_get_retile_dir <- function(tile_location) {
  return(getwd() |> paste0(
    "/",
    "data" |> file.path(
      tile_location@species,
      tile_location@name,
      tile_location@tile_name |> paste0("/")
    )
  ))
}
