#' Retrieve a data frame containing all species and corresponding areas.
#'
#' This function scans the "data" directory within the current working directory to
#' obtain a list of species. It then iterates through each species to retrieve the list
#' of areas associated with that species. The resulting data frame contains two columns:
#' "specie" representing the species and "area" representing the corresponding area.
#'
#' @return A data frame with columns "specie" and "area" containing information about
#'   all species and their associated areas.
#'
#' @seealso
#' \code{\link{list.dirs}}
#'
#' @examples
#' # Retrieve a data frame with information about all species and areas
#' all_areas_df <- lfa_get_all_areas()
#'
#' @keywords data manipulation file system
#'
#' @export
lfa_get_all_areas <- function() {
  species <-
    file.path(getwd(), "data") |> list.dirs(recursive = F, full.names = F)
  df <- NULL
  for (specie in species) {
    areas <-
      file.path(getwd(), "data", specie) |> list.dirs(recursive = F, full.names = F)
    for (area in areas) {
      if (is.null(df)) {
        df <- data.frame(specie=character(),area=character())
      }
      df[nrow(df) + 1,] <- c(specie,area)
    }
  }
  return(df)
}
