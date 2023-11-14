#' @export
lfa_ground_correction <- function(ctg, tile_location) {
  library(lidR)
  if (is.null(ctg)) {
    ctg <- read_catalog(tile_location)
  }
  opt_output_files(ctg) <-
    paste0(get_retile_dir(tile_location), "tile_norm_{ID}")
  ctg_new <- normalize_height(ctg, algorithm = tin())
  for (file in ctg$filename) {
    file.remove(file)
  }
  for (i in 1:400) {
    old_file_name <-
      paste0(get_retile_dir(tile_location),
             paste0("tile_norm_", i, ".las"))
    new_file_name <-
      paste0(get_retile_dir(tile_location), paste0("tile_", i, ".las"))
    file.rename(old_file_name, new_file_name)
  }

  return(read_catalog(tile_location))
}
