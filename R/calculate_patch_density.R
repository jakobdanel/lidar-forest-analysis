#' Calculate patch density for specified areas based on detection data
#'
#' This function calculates patch density for specified areas using detection data.
#' It reads the spatial polygons from a shapefile, computes the area size for each patch,
#' counts the number of detections in each patch, and calculates the patch density.
#'
#' @param areas_location The file path to a shapefile containing spatial polygons
#'   representing the areas for which patch density needs to be calculated.
#'   Default is "research_areas.shp".
#' @param detections A data frame containing detection information, where each row represents
#'   a detection and includes the 'area' column specifying the corresponding area.
#'   Default is obtained using lfa_get_detections().
#' @return A data frame with patch density information for each specified area.
#'   Columns include 'name' (area name), 'geometry' (polygon geometry), 'area_size' (patch area size),
#'   'detections' (number of detections in the patch), and 'density' (computed patch density).
#'
#' @examples
#' # Assuming you have a shapefile 'your_research_areas.shp' and detection data
#' # from lfa_get_detections()
#' density_data <- lfa_calculate_patch_density(areas_location = "your_research_areas.shp")
#' print(density_data)
#'
#' @export
lfa_calculate_patch_density <- function(areas_location = "research_areas.shp",
                                        detections = lfa::lfa_get_detections()) {
  # Set S2 usage to FALSE
  sf::sf_use_s2(FALSE)

  # Read spatial polygons from the specified shapefile
  patch_data <- sf::st_read(areas_location)

  # Compute the area size for each patch
  patch_data$area_size <- sf::st_area(patch_data)

  # Initialize 'detections' column with NA
  patch_data$detections <- NA

  # Count the number of detections in each patch
  for (i in 1:nrow(patch_data)) {
    patch_data[i, "detections"]$detections <- nrow(detections[detections$area == patch_data[i, "name"]$name, ])
  }

  # Calculate patch density
  patch_data$density <- patch_data$detections / patch_data$area_size

  return(patch_data)
}
