#' Create a stacked histogram for tree detections, summing up the values for each species.
#'
#' This function generates a stacked histogram using the ggplot2 package,
#' summing up the values for each species and visualizing the distribution of
#' a specified variable (\code{x_value}) on the x-axis, differentiated by another
#' variable (\code{fill_value}). The data for the plot are derived from the provided
#' \code{trees} data frame.
#'
#' @param trees A data frame containing tree detection data.
#'
#' @param x_value A character string specifying the column name used for finding the
#'   values on the x-axis of the histogram.
#'
#' @param fill_value A character string specifying the column name by which the data
#'   are differentiated in the plot.
#'
#' @param bin An integer specifying the number of bins for the histogram. Default is 30.
#'
#' @param ylab A character string specifying the y-axis label. Default is "Frequency."
#'
#' @param xlim A numeric vector of length 2 specifying the x-axis limits. Default is c(0, 100).
#'
#' @param ylim A numeric vector of length 2 specifying the y-axis limits. Default is NULL.
#'
#' @return A ggplot object representing the stacked histogram.
#'
#' @seealso
#' \code{\link{ggplot2::geom_histogram}}, \code{\link{ggplot2::ylab}},
#' \code{\link{ggplot2::scale_fill_brewer}}, \code{\link{ggplot2::coord_cartesian}}
#'
#' @examples
#' # Create a stacked histogram for variable "Z," differentiated by "area"
#' trees <- lfa_get_detections()
#' lfa_create_stacked_histogram(trees, "Z", "area")
#'
#' @keywords data visualization distribution plot ggplot2
#'
#' @export
lfa_create_stacked_histogram <-
  function(trees,
           x_value,
           fill_value,
           bin = 30,
           ylab = "Frequency",
           xlim = c(0, 100),
           ylim = NULL) {
    # Convert x_value and fill_value to symbols
    x_sym <- rlang::sym(x_value)
    fill_sym <- rlang::sym(fill_value)

    # Summarize values for the same species across different areas
    trees_summarized <- trees %>%
      dplyr::group_by(specie) %>%
      dplyr::summarise(sum_values = sum(!!x_sym))

    # Create the ggplot dynamically
    return(
      ggplot2::ggplot(trees_summarized, ggplot2::aes(
        x = specie, y = sum_values, fill = specie
      )) +
        ggplot2::geom_bar(stat = "identity", position = "stack") +
        ggplot2::ylab(ylab) +
        ggplot2::scale_fill_brewer(palette = "Set3") +
        ggplot2::coord_cartesian(xlim = xlim, ylim = ylim)
    )
  }
