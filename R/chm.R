#' Create Canopy Height Model (CHM) from Lidar Data
#'
#' This function generates a Canopy Height Model (CHM) from Lidar data using the lidR package.
#'
#' @param specie Character string indicating the species name.
#' @param area Character string indicating the specific area or location.
#' @param res Numeric value indicating the spatial resolution of the CHM. Default is 0.5.
#' @param save_to_file Logical. If TRUE, the generated CHM will be saved to a GeoTIFF file. Default is TRUE.
#' @param overwrite Logical. If TRUE, existing CHM file will be overwritten. Default is FALSE.
#' @param ... Additional arguments to be passed to the underlying functions, such as lidR::catalog_map.
#'
#' @return A raster layer representing the Canopy Height Model (CHM).
#'
#' @examples
#' # Generate CHM for a specific species and area
#' chm <- lfa_chm(specie = "ExampleSpecies", area = "ExampleArea", res = 1.0)
#'
#' # Generate CHM and save it to a file
#' chm <- lfa_chm(specie = "ExampleSpecies", area = "ExampleArea", res = 1.0, save_to_file = TRUE)
#'
#' @import lfa
#' @importFrom lidR catalog_map
#' @importFrom terra rast writeRaster
#'
#' @details
#' The behavior of the function with different input parameters is as follows:
#' - When a CHM file already exists at the specified path and `overwrite` is FALSE, the function loads the existing CHM and returns it.
#' - If the CHM file does not exist or `overwrite` is TRUE, the function processes Lidar data using `lfa_rasterize_chunk` and creates a CHM.
#' - The spatial resolution of the CHM can be controlled with the `res` parameter.
#' - If `save_to_file` is TRUE, the generated CHM will be saved to a GeoTIFF file.
#'
#' @seealso
#' \code{\link{lfa_read_area_as_catalog}}, \code{\link{catalog_map}}, \code{\link{terra::rast}}, \code{\link{terra::writeRaster}}
#'
#' @usage
#' lfa_chm(specie, area, res = 0.5, save_to_file = TRUE, overwrite = FALSE, ...)
#' @export
lfa_chm <-
  function(specie,
           area,
           res = 0.5,
           save_to_file = TRUE,
           overwrite = FALSE,
           ...) {
    path <- file.path(getwd(), "data", specie, area, "chm.tif")
    if (file.exists(path) && !overwrite) {
      print(paste("Load",path))
      return(terra::rast(path))
    }
    ctg <- lfa::lfa_read_area_as_catalog(specie, area)
    data <-
      lidR::catalog_map(ctg, lfa_rasterize_chunk, res = res, ...)
    if (save_to_file) {
      terra::writeRaster(data, path)
      print(paste("Saved", path))
    }
    return(data)
  }
