

#' Kolmogorov-Smirnov Test Wrapper Function
#'
#' This function serves as a wrapper for the Kolmogorov-Smirnov (KS) test between two samples.
#'
#' @param x A numeric vector representing the first sample.
#' @param y A numeric vector representing the second sample.
#' @param output_variable A character string specifying the output variable to extract from the ks.test result.
#'                         Default is "p.value". Other possible values include "statistic" and "alternative".
#' @param ... Additional arguments to be passed to the ks.test function.
#'
#' @return A numeric value representing the specified output variable from the KS test result.
#'
#' @details The function uses the ks.test function to perform a two-sample KS test and returns the specified output variable.
#'          The default output variable is the p-value. Other possible output variables include "statistic" and "alternative".
#'
#' @examples
#' # Perform KS test and extract the p-value
#' result <- lfa_ks_test(sample1, sample2)
#' print(result)
#'
#' # Perform KS test and extract the test statistic
#' result_statistic <- lfa_ks_test(sample1, sample2, output_variable = "statistic")
#' print(result_statistic)
#'
#' @seealso \code{\link{ks.test}}
#'
#' @importFrom stats ks.test
#'
#' @export
lfa_ks_test <- function(x, y, output_variable = "p.value", ...) {
  return(ks.test(x, y, ...)[[output_variable]])
}
