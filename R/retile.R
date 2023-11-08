


retile <- function(species, name, tile_name) {
  retile_dir = file.path("data", species, name, tile_name)
  if (file.exists(retile_dir) && file.info(retile_dir)$isdir) {
    warning("Area is already retiled, no further computings")
  } else {
    if (!file.exists(file.path("data", species, name, paste0(tile_name, ".laz")))) {
      stop("File do not exist!")
    } else {
      library(lidR)
      library(future)
      catalog = readLAScatalog(file.path("data", species, name, paste0(tile_name, ".laz")))
      plan(multisession(workers = 6))
      opt_chunk_size(catalog) <- 50
      opt_chunk_buffer(catalog) <- 0
      output_location <-
        paste0(getwd(), "/", retile_dir, "/tile_{ID}")
      cat("Write files to: ", output_location)
      opt_output_files(catalog) <- output_location
      return(catalog_retile(catalog))
    }
  }
}
