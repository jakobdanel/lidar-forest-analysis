#' Visualize Precision and Recall Metrics for Random Forest Classification
#'
#' This function creates a bar plot to visualize precision and recall metrics for each class obtained from a Random Forest classification.
#'
#' @param metrics_df Data frame containing precision and recall metrics for each class.
#'
#' @return A ggplot object representing the bar plot of precision and recall metrics.
#'
#' @examples
#' # Example data frame containing precision and recall metrics
#' example_metrics_df <- data.frame(
#'   Class = c("ClassA", "ClassB"),
#'   Precision = c(0.85, 0.92),
#'   Recall = c(0.78, 0.88)
#' )
#' # Visualize precision and recall metrics
#' lfa_visualize_rf_metrics(example_metrics_df)
#'
#' @usage
#' lfa_visualize_rf_metrics(metrics_df)
#'
#' @details
#' The function creates a bar plot to visualize precision and recall metrics for each class obtained from a Random Forest classification.
#'
#' @seealso
#' \code{\link{lfa_calculate_rf_metrics}}
#'
#' @export
lfa_visualize_rf_metrics <- function(metrics_df) {
  return(
    tidyr::gather(metrics_df, Metric, Value, -Class) |> ggplot2::ggplot(ggplot2::aes(
      x = Class, y = Value, fill = Metric
    )) +
      ggplot2::geom_bar(
        stat = "identity",
        position = "dodge",
        width = 0.7,
        color = "black"
      ) +
      ggplot2::labs(
        title = "Precision and Recall per Class",
        x = "Class",
        y = "Metric Value",
        fill = "Metric"
      ) +
      ggplot2::theme_minimal()
  )
}
