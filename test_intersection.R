library(lfa)
tls <- lfa_create_tile_location_objects()
sf <- sf::read_sf("research_areas.shp")
ctg <- lfa_intersect_areas(NULL,tls[[1]],sf)
