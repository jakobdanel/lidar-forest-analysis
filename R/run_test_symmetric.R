
#' Symmetric Pairwise Test for Categories
#'
#' This function performs a symmetric pairwise test for categories using a user-defined \code{test_function}.
#'
#' @param data A data frame containing the relevant columns.
#' @param data_column A character string specifying the column containing the numerical data.
#' @param category_column A character string specifying the column containing the categorical variable.
#' @param test_function A function used to perform the pairwise test between two sets of data.
#'                      It should accept two vectors of numeric data and additional parameters specified by \code{...}.
#'                      The function should return a numeric value representing the test result.
#' @param ... Additional parameters to be passed to the \code{test_function}.
#'
#' @return A data frame representing the results of the symmetric pairwise tests between categories.
#'
#' @details The function calculates the test results for each unique combination of categories using the specified
#'           \code{test_function}. The resulting table is symmetric, containing the test results for comparisons
#'           from the rows to the columns. The upper triangle of the matrix is filled with \code{NA} to avoid duplicate results.
#'
#' @examples
#' # Define a custom test function
#' custom_test_function <- function(x, y) {
#'   # Your test logic here
#'   # Return a numeric result
#'   return(mean(x) - mean(y))
#' }
#'
#' # Perform a symmetric pairwise test
#' result <- lfa_run_test_symmetric(your_data, "numeric_column", "category_column", custom_test_function)
#'
#' @seealso \code{\link{outer}}, \code{\link{Vectorize}}
#'
#' @export
lfa_run_test_symmetric <- function(data,
                                   data_column,
                                   category_column,
                                   test_function,
                                   ...) {
  categories <- as.factor(data[[category_column]]) |> unique()

  # Function to fill the cells of the table
  fill_table <- Vectorize(function(row, col) {
    data <- data |> as.data.frame()
    data_x <- data[data[[category_column]] == categories[row], data_column]
    data_y <- data[data[[category_column]] == categories[col], data_column]

    if (row <= col) {
      result_xy <- test_function(data_x, data_y, ...)
      return(result_xy)
    } else {
      return(NA)
    }
  })

  # Create the n x n table
  result_table <- outer(1:length(categories), 1:length(categories), fill_table)

  # Convert to a data frame for better visualization
  result_df <- as.data.frame(result_table)
  rownames(result_df) <- categories
  colnames(result_df) <- categories

  # Display the result
  return(result_df)
}
