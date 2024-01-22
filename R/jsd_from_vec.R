#' Compute Jensen-Shannon Divergence from Vectors
#'
#' This function calculates the Jensen-Shannon Divergence (JSD) between two vectors.
#'
#' @param x A numeric vector.
#' @param y A numeric vector.
#'
#' @return Jensen-Shannon Divergence between the density distributions of x and y.
#'
#' @examples
#' x <- rnorm(100)
#' y <- rnorm(100, mean = 2)
#' lfa_jsd_from_vec(x, y)
#'
#' @export
#'
lfa_jsd_from_vec <- function(x, y) {
  x.d = density(x, na.rm = TRUE)
  y.d = density(y, na.rm = TRUE)
  return(lfa::lfa_jsd(x.d$y, y.d$y))
}
