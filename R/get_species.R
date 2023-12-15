#' Get a list of species from the data directory.
#'
#' This function retrieves a list of species by scanning the "data" directory
#' located in the current working directory.
#'
#' @return A character vector containing the names of species found in the "data" directory.
#'
#' @seealso
#' \code{\link{list.dirs}}
#'
#' @references
#' This function relies on the \code{\link{list.dirs}} function for directory listing.
#'
#' @keywords data manipulation file system
#'
#' @family data retrieval functions
#'
#' @examples
#' # Retrieve the list of species
#' species_list <- lfa_get_species()
#'
#' @export
lfa_get_species <- function() {
  return(file.path(getwd(), "data") |> list.dirs(full.names = FALSE, recursive = FALSE))
}
