source("./R/utils/files.R")
source("./R/read_catalog.R")

detection <-
  function(catalog,
           species,
           name,
           tile_name,
           write_to_file = TRUE) {
    library(lidR)
    library(sf)
    library(dplyr)
    library(future)
    plan(multisession(workers = 6))
    if (is.null(catalog)) {
      if (!is_tile_existing(species, name, tile_name)) {
        stop("Can not find tile for that arguments")
      } else {
        catalog <- read_catalog(species, name, tile_name)
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
      #TODO: Implement correct savings
    }
    return(merged_results)
    # st_write(merged_results,
    #"./wienburg/tree-detections.gpkg",
    #append = F)
    
  }
