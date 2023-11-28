#' @export
is_tile_existing <- function(tile_location) {
  return(get_tiles_path(tile_location) |> file.exists())
}
