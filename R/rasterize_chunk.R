
#' Rasterize Lidar Chunk
#'
#' This function rasterizes a Lidar chunk to generate a raster representation of the canopy.
#'
#' @param chunk Lidar chunk object to be rasterized.
#' @param ... Additional arguments to be passed to the underlying lidR::rasterize_canopy function.
#'
#' @return A raster layer representing the rasterized canopy.
#'
#' @examples
#' # Example Lidar chunk
#' lidar_chunk <- readLAS("lidar_data.las", select = "xyz")
#' # Rasterize Lidar chunk
#' rasterized_canopy <- lfa_rasterize_chunk(lidar_chunk)
#'
#' @details
#' The function takes a Lidar chunk as input and uses lidR::rasterize_canopy to generate a raster representation of the canopy.
#' Additional arguments can be passed to customize the rasterization process.
#'
#' @usage
#' lfa_rasterize_chunk(chunk, ...)
#'@export
lfa_rasterize_chunk <- function(chunk, ...) {
  if (is.null(chunk)) {
    return(NULL)
  } else {
    return(lidR::rasterize_canopy(chunk, ...))
  }
}
