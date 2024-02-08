#' Plot Confusion Matrix
#'
#' This function generates a heatmap plot of a confusion matrix using ggplot2.
#'
#' @param conf_matrix Confusion matrix, typically obtained from classification evaluation.
#'
#' @return A ggplot object representing the confusion matrix heatmap plot.
#'
#' @examples
#' # Example confusion matrix
#' cm <- table(predicted = c("A", "B", "A", "B"), actual = c("A", "A", "B", "B"))
#' # Plot confusion matrix
#' lfa_plot_confusion_matrix(cm)
#'
#' @details
#' The function takes a confusion matrix as input and generates a heatmap plot using ggplot2.
#' The plot represents the relationship between the predicted and actual classes, with cell colors indicating the frequency of each combination.
#' Additionally, the plot includes labels for accuracy and kappa statistics based on the confusion matrix.
#'
#' @usage
#' lfa_plot_confusion_matrix(conf_matrix)
#'@export
lfa_plot_confusion_matrix <- function(conf_matrix) {
  library(ggplot2)
  library(caret)
  conf_matrix_df <- as.data.frame(as.table(conf_matrix))
  cm <- confusionMatrix(conf_matrix)
  max_count <- max(conf_matrix_df$Freq)
  max_combination <-
    conf_matrix_df[conf_matrix_df$Freq == max_count, c("Var1", "Var2")]
  plot <-
    ggplot(conf_matrix_df, aes(x = Var2, y = Var1, fill = Freq)) +
    geom_tile(color = "white", size = 0.5) +
    scale_fill_gradient(low = "white", high = "blue") +
    geom_text(aes(label = Freq), vjust = 1) +
    theme_minimal() +
    labs(
      title = paste0(
        "Confusion Matrix: Accuracy = ",
        cm$overall[1] |> as.numeric() |> round(4),
        ", Kappa = ",
        cm$overall[2] |> as.numeric() |> round(4)
      ),
      x = "Ground Truth",
      y = "Prediction"
    ) +
    theme(
      axis.text = element_text(size = 10),
      axis.title = element_text(size = 12),
      plot.title = element_text(size = 14, face = "bold")
    ) +
    scale_x_discrete(limits = levels(factor(conf_matrix_df$Var1))) +
    scale_y_discrete(limits = rev(levels(factor(conf_matrix_df$Var2)))) +
    theme(legend.position = "none")

  return(plot)
}
