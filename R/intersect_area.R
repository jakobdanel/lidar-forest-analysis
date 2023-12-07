
#' Intersect Lidar Catalog with Spatial Features
#'
#' This function intersects a Lidar catalog with a specific area defined by spatial features.
#'
#' @param ctg A Lidar catalog (LAScatalog object) representing the Lidar data to be processed.
#' @param tile_location A tile location object representing the specific area of interest.
#' @param areas_sf Spatial features (e.g., a SpatialPolygonsDataFrame) defining areas.
#'
#' @return A modified LAScatalog object with points outside the specified area removed.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # Example usage
#' lfa_intersect_areas(ctg, tile_location, areas_sf)
#' }
#'
#' @param ctg A LAScatalog object representing the Lidar data to be processed.
#' @param tile_location A tile location object representing the specific area of interest.
#' @param areas_sf Spatial features defining areas.
#'
#' @details
#' The function intersects the Lidar catalog specified by `ctg` with a specific area defined by
#' the `tile_location` object and `areas_sf`. It removes points outside the specified area and
#' returns a modified LAScatalog object.
#'
#' The specified area is identified based on the `species` and `name` attributes in the
#' `tile_location` object. If a matching area is not found in `areas_sf`, the function
#' stops with an error.
#'
#' The function then transforms the spatial reference of the identified area to match that of
#' the Lidar catalog using `sf::st_transform`.
#'
#' The processing is applied to each chunk in the catalog using the `identify_area` function,
#' which merges spatial information and filters out points that are not classified as inside
#' the identified area. After processing, the function writes the modified LAS files back to
#' the original file locations, removing points outside the specified area.
#'
#' If an error occurs during the processing of a chunk, a warning is issued, and the function
#' continues processing the next chunks. If no points are found after filtering, a warning is
#' issued, and NULL is returned.
#'
#' @seealso
#' Other functions in the Lidar forest analysis (LFA) package.
#'
#' @import lidR
#' @import sf
#'
#' @examples
#' \dontrun{
#' # Example usage
#' lfa_intersect_areas(ctg, tile_location, areas_sf)
#' }
#'
#' @export
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

  for(f in ctg$filename){
    las = lidR::readLAS(f)
    res = identify_area(las)
    file.remove(f)
    if(is.null(res)){
      cat("\n No intersecting area found for ", f)
    }else {
      lidR::writeLAS(res,f)
    }
  }

  return(read_catalog(tile_location))
}

