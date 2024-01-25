#' Calculate Precision and Recall Metrics for Random Forest Classification
#'
#' This function calculates precision and recall metrics for each class based on the provided confusion matrix from a Random Forest classification.
#'
#' @param conf_matrix Confusion matrix obtained from a Random Forest classification.
#'
#' @return A data frame containing precision and recall metrics for each class.
#'
#' @examples
#' # Example confusion matrix from a Random Forest classification
#' rf_cm <- table(predicted = c("A", "B", "A", "B"), actual = c("A", "A", "B", "B"))
#' # Calculate precision and recall metrics
#' rf_metrics_df <- lfa_calculate_rf_metrics(rf_cm)
#'
#' @usage
#' lfa_calculate_rf_metrics(conf_matrix)
#'
#' @details
#' The function calculates precision and recall metrics for each class based on the confusion matrix obtained from a Random Forest classification.
#'
#' @seealso
#' \code{\link{lfa_precision_per_class}}, \code{\link{lfa_recall_per_class}}
#'
#' @export
lfa_calculate_rf_metrics <- function(conf_matrix) {
  precision <- lfa::lfa_precision_per_class(conf_matrix)
  recall <- lfa::lfa_recall_per_class(conf_matrix)
  classes <- rownames(conf_matrix)

  metrics_df <- data.frame(Class = classes, Precision = precision, Recall = recall)
  return(metrics_df)
}


