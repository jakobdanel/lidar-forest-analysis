#' Compute Kullback-Leibler Divergence from Vectors
#'
#' This function calculates the Kullback-Leibler Divergence (KLD) between two vectors.
#'
#' @param x A numeric vector.
#' @param y A numeric vector.
#'
#' @return Kullback-Leibler Divergence between the density distributions of x and y.
#'
#' @examples
#' x <- rnorm(100)
#' y <- rnorm(100, mean = 2)
#' lfa_kld_from_vec(x, y)
#'
#' @export
#'
lfa_kld_from_vec <- function(x, y) {
  x.d = density(x, na.rm = TRUE)
  y.d = density(y, na.rm = TRUE)
  return(lfa::lfa_kld(x.d$y, y.d$y))
}
