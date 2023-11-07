download <- function(species, name, location) {
  mytiles = intersect_tiles2download("NRW", location) |>
    download_tiles(dir = file.path("..", "data", species, name), what = "LAZ")
}
