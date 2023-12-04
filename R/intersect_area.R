#'@export
lfa_intersect_areas <- function(ctg, tile_location, areas_sf) {
  #Find the correct polygon
  index_correct_area = -1
  for (i in 1:length(areas_sf$species)) {
    specie <- areas_sf$species[i]
    name <- areas_sf$name[i]
    if (tile_location@species == specie &&
        tile_location@name == name) {
      index_correct_area = i
    }
  }
  if (index_correct_area == -1) {
    stop("No valid area was found in the data.")
  }
  area <- areas_sf[index_correct_area,]

  ctg <- lfa_load_ctg_if_not_present(ctg, tile_location)
  area <- sf::st_transform(area, st_crs(ctg))
  identify_area <- function(chunk) {
    if (is.empty(chunk)) {
      return(NULL)
    } else {
      tryCatch(
        {
          # Merge spatial information
          chunk <- merge_spatial(chunk, area, attribute = "isInside")

          # Filter out points that are not classified as outside
          chunk <- chunk[chunk$isInside, ]

          # Check if there are points remaining after filtering
          if (is.empty(chunk) || length(chunk$X) == 0 || nrow(chunk) == 0) {
            warning("No points found after filtering. Returning NULL.")
            return(NULL)
          }

          return(chunk)
        },
        error = function(e) {
          warning("Error in merge_spatial: ", conditionMessage(e))
          return(NULL)
        }
      )
    }
  }

  opt_output_files(ctg) <-
    paste0(get_retile_dir(tile_location), "tile_intersect_{ID}")

  new_ctg <- catalog_map(ctg, identify_area)

  for (file in ctg$filename) {
    file.remove(file)
  }


  for (i in 1:400) {
    old_file_name <-
      paste0(get_retile_dir(tile_location),
             paste0("tile_intersect_", i, ".las"))
    new_file_name <-
      paste0(get_retile_dir(tile_location),
             paste0("tile_", i, ".las"))
    if (file.exists(old_file_name)) {
      file.rename(old_file_name, new_file_name)
    }
  }

  return(read_catalog(tile_location))

}

#'@export
lfa_intersect_areas_man <- function(ctg, tile_location, areas_sf) {
  #Find the correct polygon
  index_correct_area = -1
  for (i in 1:length(areas_sf$species)) {
    specie <- areas_sf$species[i]
    name <- areas_sf$name[i]
    if (tile_location@species == specie &&
        tile_location@name == name) {
      index_correct_area = i
    }
  }
  if (index_correct_area == -1) {
    stop("No valid area was found in the data.")
  }
  area <- areas_sf[index_correct_area,]

  ctg <- lfa_load_ctg_if_not_present(ctg, tile_location)
  area <- sf::st_transform(area, st_crs(ctg))
  identify_area <- function(chunk) {
    if (is.empty(chunk)) {
      return(NULL)
    } else {
      tryCatch(
        {
          # Merge spatial information
          chunk <- merge_spatial(chunk, area, attribute = "isInside")

          # Filter out points that are not classified as outside
          chunk <- chunk[chunk$isInside, ]

          # Check if there are points remaining after filtering
          if (is.empty(chunk) || length(chunk$X) == 0 || nrow(chunk) == 0) {
            warning("No points found after filtering. Returning NULL.")
            return(NULL)
          }

          return(chunk)
        },
        error = function(e) {
          warning("Error in merge_spatial: ", conditionMessage(e))
          return(NULL)
        }
      )
    }
  }

  for(f in ctg$filename){
    las = lidR::readLAS(f)
    res = identify_area(las)
    file.remove(f)
    if(is.null(res)){
      cat("No intersecting area found for ", f)
    }else {
      lidR::writeLAS(res,f)
    }
  }

  return(read_catalog(tile_location))
}

