#'Loading the catalog if it is not present
#'
#'This function checks if the catalog is `NULL`. If it is it will load the
#'catalog from the `tile_location`
#'
#'@param ctg Catalog object. Can be NULL
#'@param tile_location The location to look for the catalog tiles, if their
#'are not present
#'
#'@returns The provided ctg object if not null, else the catalog for the tiles
#'of the tile_location.
#'@export
lfa_load_ctg_if_not_present <- function(ctg, tile_location) {
  if (is.null(ctg)) {
    return(read_catalog(tile_location))
  } else {
    return(ctg)
  }
}

#' Segment the elements of an point cloud by trees
#'
#' This function will try to to divide the hole point cloud into unique trees.
#' Therefore it is assigning for each chunk of the catalog  a `treeID` for each
#' point. Therefore the algorithm uses the `li2012` implementation with the
#'  following parameters: `li2012(dt1 = 2, dt2 = 3, R = 2, Zu = 10, hmin = 5, speed_up = 12)`
#'   *NOTE*: The operation is in place and can not be reverted, the old values
#' of the point cloud will be deleted!
#'
#' @param ctg An LASCatalog object. If not null, it will perform the actions on this object, if NULL
#' inferring the catalog from the tile_location
#' @param tile_location A tile_location type object holding the information about the location of the
#' catalog. This is used to save the catalog after processing too.
#'
#' @returns A catalog where each chunk has additional `treeID` values indicating the belonging tree.
#'
#' @author Jakob Danel
#' @export
lfa_segmentation <- function(ctg, tile_location) {
  ctg <- lfa_load_ctg_if_not_present(ctg, tile_location)
  opt_output_files(ctg) <-
    paste0(get_retile_dir(tile_location), "tile_segmented_{ID}")
  trees = segment_trees(ctg,
                        li2012(
                          dt1 = 2,
                          dt2 = 3,
                          R = 2,
                          Zu = 10,
                          hmin = 5,
                          speed_up = 12
                        ),attribute = "treeID")
  for (file in ctg$filename) {
    file.remove(file)
  }
  for (i in 1:400) {
    old_file_name <-
      paste0(get_retile_dir(tile_location),
             paste0("tile_segmented_", i, ".las"))
    new_file_name <-
      paste0(get_retile_dir(tile_location), paste0("tile_", i, ".las"))
    file.rename(old_file_name, new_file_name)
  }

  return(read_catalog(tile_location))

}
