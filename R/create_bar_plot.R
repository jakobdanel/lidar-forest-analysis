#' Create a barplot using ggplot2
#'
#' This function generates a barplot using ggplot2 based on the specified data frame columns.
#' The barplot displays the values from the specified column, grouped by another column.
#' The grouping can be further differentiated by color if desired.
#'
#' @param df A data frame containing the relevant columns for the barplot.
#' @param value_column The column containing the values to be plotted.
#' @param label_column The column used for labeling the bars on the x-axis. Default is "name".
#' @param grouping_column The column used for grouping the bars. Default is "species".
#' @return A ggplot2 barplot.
#'
#'
#' @examples
#' # Assuming you have a data frame 'your_data_frame' with columns "name", "species", and "value"
#' lfa_create_barplot(your_data_frame, value_column = "value", label_column = "name", grouping_column = "species")
#'
#'@export
lfa_create_grouped_bar_plot <- function(data, grouping_var, value_col, label_col) {

if (!(grouping_var %in% colnames(data) && value_col %in% colnames(data) && label_col %in% colnames(data))) {
  stop("Columns not found in the data.frame.")
}

# Create a grouped bar plot
plot <- ggplot2::ggplot(data, ggplot2::aes(x = reorder(data[[label_col]], data[[value_col]]), y = data[[value_col]], fill = data[[grouping_var]])) +
  ggplot2::geom_bar(stat = "identity", position = "dodge") +
  ggplot2::labs(x = "Name of patch", y = "Density", fill = "Specie", title = "Tree density across the different patches, grouped by specie") +
  ggplot2::theme_minimal() +
  ggplot2::theme(axis.text.x = element_text(angle = 45, hjust = 1))

return(plot)
}

# Example usage:
# Assuming 'my_data' is your data.frame, 'category' is the grouping variable,
# 'value' is the column with values, and 'label' is the column with labels.

