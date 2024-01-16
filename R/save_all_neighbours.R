#' Save Neighbors for All Areas
#'
#' This function iterates through all detection areas, finds the n nearest trees for each tree,
#' and saves the result to a GeoPackage file for each area.
#'
#' @param n The number of nearest trees to find for each tree (default is 100).
#' @export
#'
#' @examples
#' # Save neighbors for all areas with default value (n=100)
#' lfa_save_all_neighbours()
#'
#' # Save neighbors for all areas with a specific value of n (e.g., n=50)
#' lfa_save_all_neighbours(n = 50)
#' @export
lfa_save_all_neighbours <- function (n = 100) {
  all_areas <- lfa::lfa_get_all_areas()
  for (i in 1:nrow(all_areas)) {
    cat("Find neighbours for", all_areas[i, 1], ",", all_areas[i, 2], "\n")
    out_path <-
      file.path(getwd(), "data", all_areas[i, 1], all_areas[i, 2], "neighbours.gpkg")
    lfa::lfa_get_detection_area(all_areas[i, 1], all_areas[i, 2]) |> lfa::lfa_find_n_nearest_trees(n) |> sf::st_write(out_path, append = F)
  }
  }
