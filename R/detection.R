#' @export
lfa_detection <-
  function(catalog,
           tile_location,
           write_to_file = TRUE) {
    library(lidR)
    library(sf)
    library(dplyr)
    library(future)
    plan(multisession(workers = 6))
    if (is.null(catalog)) {
      if (!lfa_is_tile_existing(tile_location)) {
        stop("Can not find tile for that arguments")
      } else {
        catalog <- lfa_read_catalog(tile_location)
      }
    }
    detect_trees <- function(chunk) {
      if (is.empty(chunk))
        return(NULL)
      return(locate_trees(chunk, lmf(ws = 8, hmin = 5)))
    }
    results <- catalog_map(catalog, detect_trees)
    merged_results <- bind_rows(results)
    if (write_to_file) {
      save_location <-
        paste0(
          lfa_get_tile_dir(tile_location),
          paste0(tile_location@tile_name, "_detection.gpkg")
        )

      st_write(merged_results,
               save_location,
               append = F)
      cat("Write file to: ", save_location)
    }
    return(merged_results)

  }
