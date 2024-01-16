#' Read LiDAR data from a specified species and location as a catalog.
#'
#' This function constructs the file path based on the specified \code{specie} and \code{location_name},
#' lists the directories at that path, and reads the LiDAR data into a \code{lidR::LAScatalog}.
#'
#' @param specie A character string specifying the species of interest.
#' @param location_name A character string specifying the name of the location.
#' @return A \code{lidR::LAScatalog} object containing the LiDAR data from the specified location and species.
#' @examples
#' \dontrun{
#' lfa_read_area_as_catalog("beech", "location1")
#' }
#' @export
lfa_read_area_as_catalog <- function(specie, location_name) {
  return(
    file.path(getwd(), "data", specie, location_name) |> list.dirs(recursive = F) |> lidR::readLAScatalog()
  )
}
