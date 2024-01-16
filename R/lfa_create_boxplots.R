#' Create a box plot from a data frame
#'
#' This function generates a box plot using ggplot2 based on the specified data frame and columns.
#'
#' @param data A data frame containing the data.
#' @param value_column The name of the column containing the values for the box plot.
#' @param category_column1 The name of the column containing the first categorical variable.
#' @param category_column2 The name of the column containing the second categorical variable.
#' @param title An optional title for the plot. If not provided, a default title is generated based on the data frame name.
#'
#' @return A ggplot object representing the box plot.
#'
#' @details The function creates a box plot where the x-axis is based on the second categorical variable,
#' the y-axis is based on the specified value column, and the box plots are colored based on the first
#' categorical variable. The grouping of box plots is done based on the unique values in the second categorical variable.
#'
#' @examples
#' \dontrun{
#' # Assuming you have a data frame 'your_data' with columns 'value', 'category1', and 'category2'
#' create_boxplot(your_data, "value", "category1", "category2")
#' }
#'
#' @export
lfa_create_boxplot <- function(data, value_column, category_column1, category_column2, title = NULL) {

  default_title <- ifelse(is.null(title), paste("Box Plot for", substitute(data)), title)

  plot <- ggplot2::ggplot(data, ggplot2::aes(x = factor(get(category_column2)), y = get(value_column), fill = factor(get(category_column1)))) +
    ggplot2::geom_boxplot() +
    ggplot2::labs(x = category_column2, y = value_column, fill = category_column1, title = default_title) +
    ggplot2::theme_minimal()

  return(plot)  # Return the ggplot object
}
