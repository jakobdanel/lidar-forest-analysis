#' Merge and Save Text Files in a Directory
#'
#' This function takes an input directory and an output name as arguments.
#' It merges the textual content of all files in the specified directory into
#' a single string, with each file's content separated by a newline character.
#' The merged content is then saved into a file named after the output name
#' in the same directory. After the merging is complete, all input files are
#' deleted.
#'
#' @param input_directory The path to the input directory containing text files.
#' @param output_name The name for the output file where the merged content will be saved.
#' @export
#'
#' @examples
#' # Merge text files in the "data_files" directory and save the result in "merged_output"
#' lfa_merge_and_save("data_files", "merged_output")
#'
#' @return This function does not explicitly return any value. It prints a message
#' indicating the successful completion of the merging and saving process.
#'
#' @details
#' This function reads the content of each text file in the specified input directory
#' and concatenates them into a single string. Each file's content is separated by a newline
#' character. The merged content is then saved into a file named after the output name
#' in the same directory. Finally, all input files are deleted from the directory.
#'
#' @seealso
#' \code{\link{readLines}}, \code{\link{writeLines}}, \code{\link{file.remove}}
#'
#' @examples
#' # Merge text files in the "data_files" directory and save the result in "merged_output"
#' lfa_merge_and_save("data_files", "merged_output")
#'
#' @export
lfa_merge_and_save <- function(input_directory, output_name) {
  # Check if the input directory exists
  if (!file.exists(input_directory) ||
      !file.info(input_directory)$isdir) {
    stop("Error: The specified input directory does not exist.")
  }

  # Get a list of files in the input directory
  files <- list.files(path = input_directory, full.names = TRUE)

  # Check if there are files in the directory
  if (length(files) == 0) {
    stop("Error: No files found in the specified directory.")
  }

  # Read the content of each file and concatenate them into a single string
  merged_content <- character()
  for (file in files) {
    content <- readLines(file, warn = FALSE)
    merged_content <- c(merged_content, content, "")
  }

  # Remove the last empty element
  merged_content <- head(merged_content,-1)

  # Concatenate the lines with a newline character
  merged_content <- paste(merged_content, collapse = "\n")

  # Save the merged content to a file in the same directory
  output_path <- file.path(input_directory, output_name)
  writeLines(merged_content, con = output_path)

  # Delete all input files
  file.remove(files)

  cat("Merging and saving completed successfully.\n")
}
