#' Create a point pattern from tree detections in a specified area for a given species.
#'
#' This function generates a point pattern from tree detections for a specific species
#' within a defined area. It filters the detections using the provided \code{species_identifier}
#' and \code{area_identifier} parameters. The area is defined by a shapefile named
#' "research_areas.shp," and the resulting point pattern is created within the specified area.
#'
#' @param species_identifier A character string specifying the target species for which
#'   the point pattern is to be generated.
#'
#' @param area_identifier A character string specifying the target area for which
#'   the point pattern is to be generated.
#'
#' @return A point pattern representing tree detections for the specified species
#'   within the defined area.
#'
#' @export
#' @seealso
#' \code{\link{lfa_get_detections}}, \code{\link{sf::st_transform}},
#' \code{\link{sf::st_union}}, \code{\link{spatstat.geom::as.owin}},
#' \code{\link{spatstat.geom::as.ppp}}
#'
#' @examples
#' lfa_create_ppp_from_area(species_identifier = "SpeciesA", area_identifier = "Area1")
#'
#' @keywords point pattern spatial data detection
#'
#'
#' @examples
#' # Create a point pattern for a specific species in a given area
#' pp <- lfa_create_ppp_from_area(species_identifier = "SpeciesA", area_identifier = "Area1")
#'
#' @export
lfa_create_ppp_from_area <-
  function(species_identifier, area_identifier) {
    trees <-
      lfa_get_detections() |> dplyr::filter(specie == species_identifier &
                                              area == area_identifier)
    area <-
      sf::read_sf("research_areas.shp") |> dplyr::filter(species == species_identifier &
                                                           name == area_identifier) |> sf::st_transform(sf::st_crs(trees))
    sf::st_union(sf::st_geometry(area)) |> spatstat.geom::as.owin() -> w
    pp <- sf::st_geometry(trees) |> spatstat.geom::as.ppp(W = w)
    return(pp)
  }


