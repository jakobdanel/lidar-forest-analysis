#' Correct the point clouds for correct ground imagery
#'
#' This function is needed to correct the Z value of the point cloud, relative to the real
#' ground height. After using this function to your catalog, the Z values can be seen as the
#' real elevation about the ground. At the moment the function uses the `tin()` function from
#' the `lidr` package. *NOTE*: The operation is inplace and can not be reverted, the old values
#' of the point cloud will be deleted!
#'
#' @param ctg An LASCatalog object. If not null, it will perform the actions on this object, if NULL
#' inferring the catalog from the tile_location
#' @param tile_location A tile_location type object holding the information about the location of the
#' cataog. This is used to save the catalog after processing too.
#'
#' @returns A catalog with the corrected z values. The catalog is always stored at tile_location and
#' holding only the transformed values.
#'
#' @author Jakob Danel
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
