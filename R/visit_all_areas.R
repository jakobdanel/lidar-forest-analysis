#' Visit All Areas and Apply Preprocessing Function
#'
#' This function iterates over all specified areas and applies a preprocessing function to each one.
#'
#' @param preprocessing_function The preprocessing function to be applied to each area. It should take specie, area, and additional parameters as inputs.
#' @param areas Data frame containing information about different areas, including columns "specie" and "area."
#' @param ... Additional arguments to be passed to the preprocessing function.
#'
#' @return A list containing the results of applying the preprocessing function to each area.
#'
#' @examples
#' # Example preprocessing function
#' my_preprocessing_function <- function(specie, area, ...) {
#'   # Your preprocessing logic here
#'   # Return the result
#'   return(result)
#' }
#' # Visit all areas and apply the preprocessing function
#' results_list <- lfa_visit_all_areas(my_preprocessing_function)
#'
#' @usage
#' lfa_visit_all_areas(preprocessing_function, areas = lfa_get_all_areas(), ...)
#'
#' @details
#' The function iterates over all areas specified in the 'areas' parameter, and for each area, it applies the provided preprocessing function.
#' The 'areas' parameter is expected to be a data frame with columns "specie" and "area," containing information about different areas to visit.
#' Additional arguments passed via '...' are forwarded to the preprocessing function.
#'
#' @seealso
#' \code{\link{lfa_get_all_areas}}
#'
#' @export
lfa_visit_all_areas <-
  function(preprocessing_function, areas = lfa_get_all_areas(), ...) {
    return_list = list()
    for (area_index in 1:nrow(areas)) {
      specie <- areas[area_index, "specie"]
      area <- areas[area_index, "area"]
      return_list[[area]] <- preprocessing_function(specie, area, ...)
    }
    return(return_list)
  }
