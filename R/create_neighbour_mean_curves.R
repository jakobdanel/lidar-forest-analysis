#' Create neighbor mean curves for specified areas
#'
#' This function generates mean curves for a specified set of areas based on neighbor data.
#' The user can choose to compute mean curves for individual neighbors or averages across neighbors.
#'
#' @param neighbors A data frame containing information about neighbors, where each column represents
#'   a specific neighbor, and each row corresponds to an area.
#' @param use_avg Logical. If TRUE, the function computes average curves across all neighbors.
#'   If FALSE, it computes curves for individual neighbors.
#' @return A data frame with mean curves for each specified area.
#'   Columns represent areas, and rows represent index values.
#'
#' @examples
#' # Assuming you have a data frame 'your_neighbors_data' with neighbor information
#' mean_curves <- lfa_create_neighbor_mean_curves(your_neighbors_data, use_avg = TRUE)
#' print(mean_curves)
#'
#' @export
lfa_create_neighbor_mean_curves <- function(neighbors, use_avg = FALSE) {
  # Get information about all areas
  all_areas <- lfa::lfa_get_all_areas()

  # Create a data frame with an 'index' column ranging from 1 to 100
  df <- data.frame(index = 1:100)

  # Define column names based on whether to use averages or individual neighbors
  if (use_avg) {
    names <- paste0("avg_", 1:100)
  } else {
    names <- paste0("Neighbor_", 1:100)
  }

  # Iterate over each area and compute mean curves
  for (area in 1:nrow(all_areas)) {
    area_name <- all_areas[area, "area"]

    # Subset data for the current area
    subset <- neighbors[neighbors$area == area_name, ]

    # Initialize an empty vector to store mean values
    vec <- NULL

    # Compute mean values for each neighbor
    for (name in names) {
      vec <- c(vec, mean(subset[[name]], na.rm = TRUE))
    }

    # Add the vector as a new column to the data frame
    df[[area_name]] <- vec
  }

  # Remove the 'index' column
  df$index <- NULL

  return(df)
}
