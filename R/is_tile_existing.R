#' @export
lfa_is_tile_existing <- function(tile_location) {
  return(lfa_get_tiles_path(tile_location) |> file.exists())
}
