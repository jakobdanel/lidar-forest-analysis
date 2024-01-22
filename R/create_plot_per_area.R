#' Create a line plot per area with one color per specie
#'
#' This function takes a data frame containing numeric columns and creates a line plot
#' using ggplot2. Each line in the plot represents a different area, with one color per specie.
#'
#' @param data A data frame with numeric columns and a column named 'specie' for species information.
#' @return A ggplot2 line plot.
#' @export
#'
#' @examples
#' data <- data.frame(
#'   specie = rep(c("Species1", "Species2", "Species3"), each = 10),
#'   column1 = rnorm(30),
#'   column2 = rnorm(30),
#'   column3 = rnorm(30)
#' )
#' lfa_create_plot_per_area(data)
#'
#'@export
lfa_create_plot_per_area <- function(data) {
  # Get all areas and species information
  areas_specie <- lfa::lfa_get_all_areas()

  # Create an "index" column using the row numbers
  data$index <- seq_len(nrow(data))

  # Reshape the data using tidyr's gather function
  data_long <- tidyr::gather(data, key = "area", value = "value", -index)

  # Perform a left join with areas_specie
  data_long <- dplyr::left_join(data_long, areas_specie, by = "area")

  # Create a line plot using ggplot2 with colors based on specie and one line per area
  return(
    ggplot2::ggplot(data_long, ggplot2::aes(x = index, y = value, color = specie, group = area)) +
      ggplot2::geom_line() +
      ggplot2::labs(
        title = "Average Distance to n-nearest Neighbors across all patches",
        x = "n",
        y = "Average Distance to n-nearest Neighbor (m)"
      ) +
      ggplot2::theme_minimal()
  )
}
