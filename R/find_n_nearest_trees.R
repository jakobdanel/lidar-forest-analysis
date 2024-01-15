#' Find n Nearest Trees
#'
#' This function calculates the distances to the n nearest trees for each tree in the input dataset.
#'
#' @param trees A sf object containing tree coordinates.
#' @param n The number of nearest trees to find for each tree (default is 100).
#' @return A data frame with additional columns representing the distances to the n nearest trees.
#'
#' @examples
#' # Load tree data using lfa_get_detections() (not provided)
#' tree_data <- lfa_get_detections()
#'
#' # Filter tree data for a specific species and area
#' tree_data = tree_data[tree_data$specie == "pine" & tree_data$area == "greffen", ]
#'
#' # Find the 100 nearest trees for each tree in the filtered dataset
#' tree_data <- lfa_find_n_nearest_trees(tree_data)
#'
#'@export
lfa_find_n_nearest_trees <- function(trees, n = 100) {
  coordinates <- sf::st_coordinates(trees)

  distances_matrix <- matrix(NA, nrow = nrow(coordinates), ncol = n)

  cat("Calculate ", nrow(coordinates), "entries")
  for (i in seq_len(nrow(coordinates))) {
    query_point <- coordinates[i,]
    neighbors <-
      spdep::knn2nb(spdep::knearneigh(coordinates, k = n))

    # Extract the coordinates of neighbors and create an sf object
    neighbor_indices <- unlist(neighbors[[i]])
    neighbors_sf <- trees[neighbor_indices,]

    # Set CRS for query point
    query_point_sf <-
      sf::st_sfc(sf::st_point(c(query_point[1], query_point[2])), crs = sf::st_crs(trees))

    distances <- sf::st_distance(query_point_sf, neighbors_sf)
    distances <- distances[order(distances)]
    distances_matrix[i, ] <- distances
    cat(i, "/", nrow(coordinates), "\n")
  }
  distances_matrix <- distances_matrix |> data.frame()
  colnames(distances_matrix) <- paste0("Neighbor_", 1:n)
  trees <- dplyr::bind_cols(trees, distances_matrix)
  return(trees)
}
