source("./R/utils/files.R")

read_catalog <- function(species,name,tile_name){
  library(lidR)
  return(get_retile_dir(species,name,tile_name) |>
    list.files(full.names = T) |>
    readLAScatalog()
  )
}
