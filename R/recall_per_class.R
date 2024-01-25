#' Calculate Recall per Class from Confusion Matrix
#'
#' This function calculates recall for each class based on the provided confusion matrix.
#'
#' @param confusion_matrix Confusion matrix obtained from a classification evaluation.
#'
#' @return A numeric vector representing recall for each class.
#'
#'
#' @examples
#' # Example confusion matrix
#' cm <- table(predicted = c("A", "B", "A", "B"), actual = c("A", "A", "B", "B"))
#' # Calculate recall per class
#' recall_vector <- lfa_recall_per_class(cm)
#'
#' @usage
#' lfa_recall_per_class(confusion_matrix)
#'
#' @details
#' Recall (Sensitivity or True Positive Rate) is a measure of the ability of a classification model to identify all relevant instances. It is calculated as the ratio of true positives to the sum of true positives and false negatives.
#'
#' @seealso
#' \code{\link{lfa_precision_per_class}}
#'
#' @export
lfa_recall_per_class <- function(confusion_matrix){
  num_classes <- nrow(confusion_matrix)
  recall <- numeric(num_classes)

  for (i in 1:num_classes) {
    true_positive <- confusion_matrix[i, i]
    false_negative <- sum(confusion_matrix[i, ]) - true_positive

    recall[i] <- true_positive / (true_positive + false_negative)
  }

  return(recall)
}
