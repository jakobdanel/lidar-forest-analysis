#' Map Function Over Tile Locations
#'
#' This function applies a specified mapping function to each tile location in a list.
#'
#' @param tile_locations A list of tile location objects.
#' @param map_function The mapping function to be applied to each tile location.
#'   The function should take a tile location object as its first argument,
#'   and additional arguments can be passed using the ellipsis (`...`) syntax.
#' @param ... Additional arguments to be passed to the mapping function.
#'
#' @return None
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # Example usage
#' lfa_map_tile_locations(tile_locations, my_mapping_function, param1 = "value")
#' }
#'
#' @param tile_locations A list of tile location objects.
#' @param map_function The mapping function to be applied to each tile location.
#' @param ... Additional arguments to be passed to the mapping function.
#'
#' @details
#' This function iterates over each tile location in the provided list (`tile_locations`)
#' and applies the specified mapping function (`map_function`) to each tile location.
#' The mapping function should accept a tile location object as its first argument, and
#' additional arguments can be passed using the ellipsis (`...`) syntax.
#'
#' This function is useful for performing operations on multiple tile locations concurrently,
#' such as loading Lidar data, processing areas, or other tasks that involve tile locations.
#'
#' @seealso
#' The mapping function provided should be compatible with the structure and requirements
#' of the tile locations and the specific task being performed.
#'
#' @examples
#' \dontrun{
#' # Example usage
#' lfa_map_tile_locations(tile_locations, my_mapping_function, param1 = "value")
#' }
#'
#' @export
lfa_map_tile_locations <-
  function(tile_locations,
           map_function,
           check_flag = NULL,
           ...) {
    if (!is.null(check_flag)) {
      if (lfa_check_flag(check_flag)) {
        cat("Function is already computed, no further computings here")
        return()
      }
    }
    for (i in 1:length(tile_locations)) {
      map_function(tile_location = tile_locations[[i]], ...)
    }
    if (!is.null(check_flag)) {
      lfa_set_flag(check_flag)
    }
  }
