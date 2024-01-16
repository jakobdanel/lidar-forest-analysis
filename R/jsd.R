#' Jensen-Shannon Divergence Calculation
#'
#' This function calculates the Jensen-Shannon Divergence (JSD) between two probability distributions P and Q.
#'
#' @param p A numeric vector representing the probability distribution P.
#' @param q A numeric vector representing the probability distribution Q.
#' @param epsilon A small positive constant added to both P and Q to avoid logarithm of zero. Default is 1e-10.
#'
#' @return A numeric value representing the Jensen-Shannon Divergence between P and Q.
#'
#' @details The JSD is computed using the Kullback-Leibler Divergence (KLD) as follows:
#' \code{sum((p * log((p + epsilon) / (m + epsilon)) + q * log((q + epsilon) / (m + epsilon))) / 2)}
#' where \code{m = (p + q) / 2}.
#'
#' @examples
#' # Calculate JSD between two probability distributions
#' p_distribution <- c(0.2, 0.3, 0.5)
#' q_distribution <- c(0.1, 0, 0.9)
#' jsd_result <- jsd(p_distribution, q_distribution)
#' print(jsd_result)
#'
#' @seealso \code{\link{kld}}, \code{\link{sum}}, \code{\link{log}}
#'
#' @export
lfa_jsd <- function(p, q, epsilon = 1e-10) {
  m <- (p + q) / 2
  kld_pm <- sum(p * log((p + epsilon) / (m + epsilon)))
  kld_qm <- sum(q * log((q + epsilon) / (m + epsilon)))
  return((kld_pm + kld_qm) / 2)
}
