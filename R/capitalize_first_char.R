#' Capitalize First Character of a String
#'
#' This function takes a string as input and returns the same string with the
#' first character capitalized. If the first character is already capitalized,
#' the function does nothing. If the first character is not from the alphabet,
#' an error is thrown.
#'
#' @param input_string A single-character string to be processed.
#'
#' @return A modified string with the first character capitalized if it is
#' not already. If the first character is already capitalized, the original
#' string is returned.
#'
#' @examples
#' # Capitalize the first character of a string
#' capitalize_first_char("hello") # Returns "Hello"
#' capitalize_first_char("World") # Returns "World"
#'
#' # Error example (non-alphabetic first character)
#' capitalize_first_char("123abc") # Throws an error
#'
#' @details
#' This function performs the following steps:
#'   - Checks if the input is a single-character string.
#'   - Verifies if the first character is from the alphabet (A-Z or a-z).
#'   - If the first character is not already capitalized, it capitalizes it.
#'   - Returns the modified string.
#'
#' @seealso
#' This function is related to the basic string manipulation functions in base R.
#'
#' @references
#' None
#'
#' @note
#' This function is case-sensitive and assumes ASCII characters.
#'
#' @family String Manipulation
#'
#' @keywords string capitalize first character alphabet error
#' @export
lfa_capitalize_first_char <- function(input_string) {
  if (!is.character(input_string) || length(input_string) != 1) {
    stop("Input must be a single character string.")
  }

  first_char <- substr(input_string, 1, 1)

  if (!grepl("[A-Za-z]", first_char)) {
    stop("Error: The first character is not from the alphabet.")
  }

  if (first_char != toupper(first_char)) {
    # If the first character is not already capitalized
    return(paste(toupper(first_char), substr(input_string, 2, nchar(input_string)), sep = ""))
  } else {
    # If the first character is already capitalized
    return(input_string)
  }
}
