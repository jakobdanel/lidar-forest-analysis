#' Initialize data structure for species and areas
#'
#' This function initializes the data structure for storing species and associated areas.
#'
#' @param sf_species A data frame with information about species and associated areas.
#'   It must include columns like "species" and "name" to create the directory structure.
#'   See details for more information.
#'
#' @return None
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # Example species data frame
#' sf_species <- data.frame(
#'   species = c("SpeciesA", "SpeciesB"),
#'   name = c("Area1", "Area2"),
#'   # Other necessary columns
#' )
#'
#' lfa_init_data_structure(sf_species)
#' }
#'
#' @param sf_species A data frame with information about species and associated areas.
#'
#' @details
#' The input data frame, `sf_species`, should have at least the following columns:
#' - "species": The names of the species for which the data structure needs to be initialized.
#' - "name": The names of the associated areas.
#'
#' The function creates directories based on the species and area information provided in
#' the `sf_species` data frame. It checks whether the directories already exist and creates
#' them if they don't.
#'
#' @examples
#' \dontrun{
#' # Example species data frame
#' sf_species <- data.frame(
#'   species = c("SpeciesA", "SpeciesB"),
#'   name = c("Area1", "Area2"),
#'   # Other necessary columns
#' )
#'
#' lfa_init_data_structure(sf_species)
#' }
#'
#' @export
lfa_init_data_structure <- function(sf_species) {
  data_dir <- file.path(getwd(), "data")
  if (!(file.exists(data_dir) && file.info(data_dir)$isdir)) {
    dir.create(data_dir)
    cat("Created dir: ", data_dir, "\n")
  }
  for (i in 1:length(sf_species$species)) {
    path <- file.path(data_dir, sf_species$species[i])
    if (!(file.exists(path) && file.info(path)$isdir)) {
      dir.create(path)
      cat("Created dir: ", path, "\n")
    }

    for (j in 1:length(sf_species$name)) {
      subpath <- file.path(path, sf_species$name[j])
      if (!(file.exists(subpath) &&
            file.info(subpath)$isdir) &&
          sf_species$species[j] == sf_species$species[i]) {
        dir.create(subpath)
        cat("Created dir: ", subpath, "\n")
      }
    }
  }
}
