
#' @export
setClass(
  "tile_location",
  slots = list(
    species = "character",
    name = "character",
    tile_name = "character"
  )
)

#' @export
true_example_location = new(
  "tile_location",
  species = "test",
  name = "test",
  tile_name = "3dm_32_356_5645_1_nw"
)

#' @export
wrong_example_location = new(
  "tile_location",
  species = "tet",
  name = "test",
  tile_name = "3dm_32_356_5645_1_nw"
)
