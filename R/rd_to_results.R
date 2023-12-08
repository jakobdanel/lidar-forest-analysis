#' Convert Rd Files to Markdown and Merge Results
#'
#' This function converts all Rd (R documentation) files in the "man" directory
#' to Markdown format (.qmd) and saves the converted files in the "results/appendix/package-docs" directory.
#' It then merges the converted Markdown files into a single string and saves
#' the merged content into a file named "docs.qmd" in the "results/appendix/package-docs" directory.
#'
#' @export
#'
#' @details
#' The function performs the following steps:
#'   - Removes any existing "docs.qmd" file in the "results/appendix/package-docs" directory.
#'   - Finds all Rd files in the "man" directory.
#'   - Converts each Rd file to Markdown format (.qmd) using the `lfa_rd_to_qmd` function.
#'   - Saves the converted Markdown files in the "results/appendix/package-docs" directory.
#'   - Merges the content of all converted Markdown files into a single string.
#'   - Saves the merged content into a file named "docs.qmd" in the "results/appendix/package-docs" directory.
#'
#' @seealso
#' \code{\link{lfa_rd_to_qmd}}, \code{\link{lfa_merge_and_save}}
#'
#' @examples
#' # Convert Rd files to Markdown and merge the results
#' lfa_rd_to_results()
#'
#' @return
#' This function does not explicitly return any value. It performs the conversion,
#' merging, and saving operations as described in the details section.
#'
#' @export
lfa_rd_to_results <- function() {
  # find all files
  file.remove(file.path(getwd(), "results", "appendix", "package-docs", "docs.qmd"))
  files <-
    list.files(path = "./man/",
               pattern = ".Rd",
               full.names = "FALSE")
  names <- tools::file_path_sans_ext(files)
  in_path <- file.path(getwd(), "man", files)
  out_path <-
    file.path(getwd(),
              "results",
              "appendix",
              "package-docs",
              paste0(names, ".qmd"))
  for (i in 1:length(in_path)) {
    if (file.exists(out_path[i])) {
      file.remove(out_path[i])
    }
    lfa_rd_to_qmd(in_path[i], out_path[i])
  }
  lfa_merge_and_save(file.path(getwd(), "results", "appendix", "package-docs"),
                     "docs.qmd")
}
