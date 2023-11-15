#' Create tile location objects
#'
#' This function traverses a directory structure to find LAZ files and creates
#' tile location objects for each file. The function looks into the the `data`
#' directory of the repository/working directory. It then creates `tile_location`
#' objects based on the folder structure. The folder structure should not be
#' touched by hand, but created by `lfa_init_data_structure()` which builds the
#' structure based on a shape file.
#'
#' @return A vector containing tile location objects.
#' @examples
#' lfa_create_tile_location_objects()
#'
#' @seealso \code{\link{tile_location}}
#'
#' @param None
#
#' @examples
#' \dontrun{
#' lfa_create_tile_location_objects()
#' }
#' @author Jakob Danel
#' @export
lfa_create_tile_location_objects <- function() {
  locations = vector()
  base_dir <- file.path(getwd(), "data")
  for (specie in list.files(base_dir)) {
    specie_dir <- file.path(base_dir, specie)
    for (name in list.files(specie_dir)) {
      name_dir <- file.path(specie_dir, name)
      dir_entries = list.files(name_dir)
      tiles = grep(".laz", dir_entries)
      for (tile in tiles) {
        new_location = new(
          "tile_location",
          species = specie,
          name = name,
          tile_name = strsplit(dir_entries[tile], ".", fixed = T)[[1]][1]
        )
        print(new_location)
        locations <- append(locations, c(new_location))
      }
    }
  }
  return(locations)
}
