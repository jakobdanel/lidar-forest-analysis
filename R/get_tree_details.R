


#'@export
lfa_convex_hull <- function() {
  areas <- lfa::lfa_get_all_areas()
  results <- NULL
  for (i in 1:length(areas$area)) {
    area <- areas[i, "area"]
    specie <- areas[i, "specie"]
    print(paste0(specie, ": ", area))
    ctg <- lfa::lfa_read_area_as_catalog(specie, area)
    crs = sf::st_crs(ctg$geometry)
    all_polys = NULL
    for (j in 1:length(ctg$filename)) {
      print(j)
      las <- lidR::readLAS(ctg$filename[j])
      sf_ctg = sf::st_as_sf(las, coords = c("X", "Y"), crs = crs)
      sf_ctg |> group_by(treeID) -> grouped
      grouped |> summarise() |> sf::st_convex_hull() -> polys
      # print(las)
      polys$density = -1
      polys$Z.mean = -1
      polys$Z.var = -1
      polys$Intensity.mean = -1
      polys$Intensity.var = -1
      polys$number_of_returns = -1


      polys$name_las_file = ctg$filename[j]
      # print(polys)
      for (k in 1:nrow(polys)) {
        treeID <- polys[k, ]$treeID
        if(!is.na(treeID)){
        tree_las = NULL
        tree_las <- las[!is.na(las$treeID)&las$treeID == treeID, ]

        polys$density[k] <- lidR::density(tree_las)
        polys$Z.mean[k] = mean(tree_las$Z)
        polys$Z.var[k] = var(tree_las$Z)

        polys$Intensity.mean[k] = mean(tree_las$Intensity)
        polys$Intensity.var[k] = var(tree_las$Intensity)

        polys$number_of_returns[k] = length(tree_las$X)
        }
      }
      polys$tree_area = sf::st_area(polys)
      if (is.null(all_polys)) {
        all_polys = polys
      } else {
        all_polys = dplyr::bind_rows(all_polys, polys)
      }
    }
    det <- lfa::lfa_get_detection_area(specie, area)
    joined <- sf::st_join(det, all_polys, join = sf::st_within)
    unique_joined <-
      joined[!duplicated(st_geometry(joined), fromLast = TRUE), ]
    names(unique_joined)[names(unique_joined) == 'treeID.x'] <- 'treeID.detection'
    names(unique_joined)[names(unique_joined) == 'treeID.y'] <- 'treeID.segmentation'
    if (results |> is.null()) {
      results <- unique_joined
    } else {
      results <- dplyr::bind_rows(results, unique_joined)
    }
  }
  return(results)
}
