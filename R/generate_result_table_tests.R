#' Generate Result Table for Tests
#'
#' This function generates a result table for tests using the knitr::kable function.
#'
#' @param table A data frame representing the result table.
#'
#' @return A formatted table suitable for HTML output with lines between columns and rows.
#'
#' @details This function uses the knitr::kable function to create a formatted table, making it suitable for HTML output.
#'          The input table is expected to be a data frame with test results, and the resulting table will have capitalized
#'          row and column names with lines between columns and rows.
#'
#' @examples
#' # Generate a result table for tests
#' result_table <- data.frame(
#'   Test1 = c(0.05, 0.10, 0.03),
#'   Test2 = c(0.02, 0.08, 0.01),
#'   Test3 = c(0.08, 0.12, 0.05)
#' )
#' formatted_table <- lfa_generate_result_table_tests(result_table)
#' print(formatted_table)
#'
#'
#' @export
lfa_generate_result_table_tests <- function(table, caption = "Table Caption") {
  # Capitalize row and column names in the resulting table
  table <- as.data.frame(table)
  table <- format.data.frame(table, digits = 2)
  rownames(table) <- tools::toTitleCase(rownames(table))
  colnames(table) <- tools::toTitleCase(colnames(table))

  # Generate a formatted table suitable for HTML output with lines between columns and rows
  return(knitr::kable(table, "html", caption = caption, table.attr = 'class="table table-bordered"') |>
           kableExtra::kable_styling(full_width = FALSE) |>
           kableExtra::column_spec(1,bold = T))
}


