#' Create density plots for groups in a data frame
#'
#' This function generates density plots using ggplot2 based on the specified data frame and columns.
#'
#' @param data A data frame containing the data.
#' @param value_column The name of the column containing the values for the density plot.
#' @param category_column1 The name of the column containing the categorical variable for grouping.
#' @param category_column2 The name of the column containing the categorical variable for arranging plots.
#' @param title An optional title for the plot. If not provided, a default title is generated based on the data frame name.
#' @param xlims Optional limits for the x-axis. Should be a numeric vector with two elements (lower and upper bounds).
#' @param ylims Optional limits for the y-axis. Should be a numeric vector with two elements (lower and upper bounds).
#'
#' @return A ggplot object representing the density plots arranged in a 2x2 grid.
#'
#' @details The function creates density plots where the x-axis is based on the specified value column,
#' and the density plots are colored based on the first categorical variable. The arrangement of plots
#' is done based on the unique values in the second categorical variable. The plots are arranged in a 2x2 grid.
#'
#' @examples
#' \dontrun{
#' # Assuming you have a data frame 'your_data' with columns 'value', 'category1', and 'category2'
#' create_density_plots(your_data, "value", "category1", "category2", title = "Density Plots", xlims = c(0, 10), ylims = c(0, 0.5))
#' }
#'
#' @export
lfa_create_density_plots <-
  function(data,
           value_column,
           category_column1,
           category_column2,
           title = NULL,
           xlims = NULL,
           ylims = NULL) {
    default_title <-
      ifelse(is.null(title),
             paste("Density Plots for", substitute(data)),
             title)

    plot <-
      ggplot2::ggplot(data, ggplot2::aes(x = get(value_column), fill = factor(get(category_column1)))) +
      ggplot2::geom_density(alpha = 0.5) +
      ggplot2::facet_wrap( ~ factor(get(category_column2)), nrow = 2, ncol = 2) +
      ggplot2::labs(x = value_column, fill = category_column1, title = default_title) +
      ggplot2::theme_minimal()

    if (!is.null(xlims)) {
      plot <- plot + ggplot2::xlim(xlim = xlims)
    }
    if (!is.null(ylims)) {
      plot <- plot + ggplot2::ylim(ylims)
    }

    return(plot)
  }
