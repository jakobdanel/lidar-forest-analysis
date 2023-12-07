#' Get the path to a flag file indicating the completion of a specific process.
#'
#' This function constructs and returns the path to a hidden flag file, which serves as an indicator that a particular processing step has been completed. The flag file is created in a designated location within the working directory.
#'
#' @param flag_name A character string specifying the name of the flag file. It should be a descriptive and unique identifier for the process being flagged.
#'
#' @return A character string representing the absolute path to the hidden flag file.
#'
#' @export
#' @examples
#' # Get the flag path for a process named "data_processing"
#' lfa_get_flag_path("data_processing")
lfa_get_flag_path <- function(flag_name) {
  return(file.path(getwd(), "data", paste0(".", flag_name)))
}

#' Set a flag to indicate the completion of a specific process.
#'
#' This function creates a hidden flag file at a specified location within the working directory to indicate that a particular processing step has been completed. If the flag file already exists, a warning is issued.
#'
#' @param flag_name A character string specifying the name of the flag file. It should be a descriptive and unique identifier for the process being flagged.
#'
#' @return This function does not have a formal return value.
#'
#' @export
#' @examples
#' # Set the flag for a process named "data_processing"
#' lfa_set_flag("data_processing")
lfa_set_flag <- function(flag_name) {
  flag_path <- lfa_get_flag_path(flag_name)
  if (file.exists(flag_path)) {
    warning(paste0("Flag ", flag_name, " is already set."))
  } else {
    file.create(flag_path)
  }
}

#' Check if a flag is set, indicating the completion of a specific process.
#'
#' This function checks for the existence of a hidden flag file at a specified location within the working directory. If the flag file is found, a message is printed, and the function returns `TRUE` to indicate that the associated processing step has already been completed. If the flag file is not found, the function returns `FALSE`, indicating that further processing can proceed.
#'
#' @param flag_name A character string specifying the name of the flag file. It should be a descriptive and unique identifier for the process being checked.
#'
#' @return A logical value indicating whether the flag is set (`TRUE`) or not (`FALSE`).
#'
#' @export
#' @examples
#' # Check if the flag for a process named "data_processing" is set
#' lfa_check_flag("data_processing")
lfa_check_flag <- function(flag_name) {
  if (file.exists(lfa_get_flag_path(flag_name))) {
    cat("No further processing: flag", flag_name, "is set!")
    return(TRUE)
  }
  return(FALSE)
}
