#' Create a stacked distribution plot for tree detections, visualizing the distribution
#' of a specified variable on the x-axis, differentiated by another variable.
#'
#' This function generates a stacked distribution plot using the ggplot2 package,
#' providing a visual representation of the distribution of a specified variable
#' (\code{x_value}) on the x-axis, with differentiation based on another variable
#' (\code{fill_value}). The data for the plot are derived from the provided \code{trees}
#' data frame.
#'
#' @param trees A data frame containing tree detection data.
#'
#' @param x_value A character string specifying the column name used for finding the
#'   values on the x-axis of the histogram.
#'
#' @param fill_value A character string specifying the column name by which the data
#'   are differentiated in the plot.
#'
#' @param bin An integer specifying the number of bins for the histogram. Default is 100.
#'
#' @param ylab A character string specifying the y-axis label. Default is "Amount trees."
#'
#' @param xlim A numeric vector of length 2 specifying the x-axis limits. Default is c(0, 100).
#'
#' @param ylim A numeric vector of length 2 specifying the y-axis limits. Default is c(0, 1000).
#'
#' @param title The title of the plot.
#'
#' @return A ggplot object representing the stacked distribution plot.
#'
#' @seealso
#' \code{\link{ggplot2::geom_histogram}}, \code{\link{ggplot2::facet_wrap}},
#' \code{\link{ggplot2::ylab}}, \code{\link{ggplot2::scale_fill_brewer}},
#' \code{\link{ggplot2::coord_cartesian}}
#'
#' @examples
#' # Create a stacked distribution plot for variable "Z," differentiated by "area"
#' trees <- lfa_get_detections()
#' lfa_create_stacked_distributions_plot(trees, "Z", "area")
#'
#' @keywords data visualization distribution plot ggplot2
#'
#' @export
lfa_create_stacked_distributions_plot <-
  function(trees,
           x_value,
           fill_value,
           bin = 100,
           ylab = "Amount trees",
           xlim = c(0, 100),
           ylim = c(0, 1000),
           title = "Histograms of height distributions between species 'beech', 'oak', 'pine' and 'spruce' divided by the different areas of Interest"
           ) {
    # Convert x_value and fill_value to symbols
    x_sym <- rlang::sym(x_value)
    fill_sym <- rlang::sym(fill_value)

    # Create the ggplot dynamically
    return(
      ggplot2::ggplot(trees, ggplot2::aes(
        x = !!x_sym, fill = !!fill_sym
      )) +
        ggplot2::geom_histogram(
          bins = bin,
          color = "white",
          alpha = 0.7,
          position = "stack"
        ) +
        ggplot2::facet_wrap(~ specie, scales = "free") +
        ggplot2::ylab(ylab) +
        ggplot2::scale_fill_brewer(palette = "Set3") +
        ggplot2::coord_cartesian(xlim = xlim, ylim = ylim) +
        ggplot2::ggtitle(title)
    )
  }
