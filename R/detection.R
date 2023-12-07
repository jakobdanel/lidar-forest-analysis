#' Perform tree detection on a lidar catalog and optionally save the results to a file.
#'
#' This function utilizes lidar data to detect trees within a specified catalog. The detected tree information can be optionally saved to a file in the GeoPackage format. The function uses parallel processing to enhance efficiency.
#'
#' @param catalog A lidar catalog containing point cloud data. If set to NULL, the function attempts to read the catalog from the specified tile location.
#'
#' @param tile_location An object specifying the location of the lidar tile. If catalog is NULL, the function attempts to read the catalog from this tile location.
#'
#' @param write_to_file A logical value indicating whether to save the detected tree information to a file. Default is TRUE.
#'
#' @return A sf style data frame containing information about the detected trees.
#'
#' @export
#' @examples
#' # Perform tree detection on a catalog and save the results to a file
#' lfa_detection(catalog = my_catalog, tile_location = my_tile_location, write_to_file = TRUE)
lfa_detection <-
  function(catalog,
           tile_location,
           write_to_file = TRUE) {
    future::plan(multisession(workers = 6))
    if (is.null(catalog)) {
      if (!is_tile_existing(tile_location)) {
        stop("Can not find tile for that arguments")
      } else {
        catalog <- read_catalog(tile_location)
      }
    }
    detect_trees <- function(chunk) {
      if (is.empty(chunk))
        return(NULL)
      return(lidR::locate_trees(chunk, lmf(ws = 8, hmin = 5)))
    }
    results <- lidR::catalog_map(catalog, detect_trees)
    merged_results <- dplyr::bind_rows(results)
    if (write_to_file) {
      save_location <-
        paste0(
          get_tile_dir(tile_location),
          paste0(tile_location@tile_name, "_detection.gpkg")
        )
      if (file.exists(save_location)) {
        warning(paste0("File ", save_location, " already exists!"))
        return(merged_results)
      }
      sf::st_write(merged_results,
                   save_location,
                   append = F)
      cat("Write file to: ", save_location)
    }
    return(merged_results)

  }
