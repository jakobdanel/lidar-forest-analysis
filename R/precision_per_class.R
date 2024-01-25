#' Calculate Precision per Class from Confusion Matrix
#'
#' This function calculates precision for each class based on the provided confusion matrix.
#'
#' @param confusion_matrix Confusion matrix obtained from a classification evaluation.
#'
#' @return A numeric vector representing precision for each class.
#'
#' @examples
#' # Example confusion matrix
#' cm <- table(predicted = c("A", "B", "A", "B"), actual = c("A", "A", "B", "B"))
#' # Calculate precision per class
#' precision_vector <- lfa_precision_per_class(cm)
#'
#' @usage
#' lfa_precision_per_class(confusion_matrix)
#'
#' @details
#' Precision is a measure of the accuracy of the positive predictions for a specific class. It is calculated as the ratio of true positives to the sum of true positives and false positives.
#'
#' @seealso
#' \code{\link{lfa_recall_per_class}}, \code{\link{lfa_f1_score_per_class}}
#'
#' @export
lfa_precision_per_class <-function(confusion_matrix){
    num_classes <- nrow(confusion_matrix)
    precision <- numeric(num_classes)

    for (i in 1:num_classes) {
      true_positive <- confusion_matrix[i, i]
      false_positive <- sum(confusion_matrix[, i]) - true_positive

      precision[i] <- true_positive / (true_positive + false_positive)
    }

    return(precision)
}
