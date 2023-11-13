#' @export
read_catalog <- function(tile_location) {
  library(lidR)
  return(tile_location |>
           get_retile_dir() |>
           list.files(full.names = T) |>
           readLAScatalog())
}
