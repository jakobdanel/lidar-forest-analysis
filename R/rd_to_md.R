#' Convert Rd File to Markdown
#'
#' *IMPORTANT NOTE:*
#' This function is nearly identical to the `Rd2md::Rd2markdown` function from the `Rd2md`
#' package. We needed to implement our own version of it because of various reasons:
#'   - The algorithm uses hardcoded header sizes (h1 and h2 in original) which is not feasible for our use-case of the markdown.
#'   - We needed to add some Quarto Markdown specifics, e.g. to make sure that the examples will not be runned.
#'   - We want to exclude certain tags from our implementation.
#'
#' For that reason we copied the method and made changes as needed and also added this custom documentation.
#'
#' This function converts an Rd (R documentation) file to Markdown format (.md) and
#' saves the converted file at the specified location. The function allows appending
#' to an existing file or creating a new one. The resulting Markdown file includes
#' sections for the function's name, title, and additional content such as examples,
#' usage, arguments, and other sections present in the Rd file.
#'
#' @param rdfile The path to the Rd file or a parsed Rd object.
#' @param outfile The path to the output Markdown file (including the file extension).
#' @param append Logical, indicating whether to append to an existing file (default is FALSE).
#'
#' @export
#'
#' @details
#' The function performs the following steps:
#'   - Parses the Rd file using the Rd2md package.
#'   - Creates a Markdown file with sections for the function's name, title, and additional content.
#'   - Appends the content to an existing file if `append` is set to TRUE.
#'   - Saves the resulting Markdown file at the specified location.
#'
#' @seealso
#' \code{\link{Rd2md::parseRd}}
#'
#' @examples
#' # Convert Rd file to Markdown and save it
#' lfa_rd_to_md("path/to/your/file.Rd", "path/to/your/output/file.md")
#'
#' # Convert Rd file to Markdown and append to an existing file
#' lfa_rd_to_md("path/to/your/file.Rd", "path/to/existing/output/file.md", append = TRUE)
#'
#' @return
#' This function does not explicitly return any value. It saves the converted Markdown file
#' at the specified location as described in the details section.
#' @export
lfa_rd_to_qmd <- function(rdfile, outfile, append = FALSE)
{
  append <- as.logical(append)
  if (length(append) != 1)
    stop("Please provide append as single logical value.")
  if (is.character(rdfile))
    if ((length(rdfile) != 1))
      stop("Please provide rdfile as single character value (file path with extension).")
  outfile <- as.character(outfile)
  if (length(outfile) != 1)
    stop("Please provide outfile as single character value (file path with extension).")
  if (append) {
    if (!file.exists(outfile))
      stop("If append=TRUE, the outfile must exists already.")
  }
  type <- ifelse(inherits(rdfile, "Rd"), "bin", "src")
  file.ext <- "qmd"
  section <- "###"
  subsection <- "####"
  section.sep <- "\n\n"
  run.examples <- FALSE
  if (type == "src") {
    rd <- tools::parse_Rd(rdfile)
  }
  else {
    if (inherits(rdfile, "list")) {
      rdfile = rdfile[[1]]
    }
    rd <- rdfile
    class(rd) <- "Rd"
  }
  results <- Rd2md::parseRd(rd)
  if (all(c("name", "title") %in% names(results))) {
    filename <- paste0(results$name, ".", file.ext)
    results$filename <- filename
    results$directory <- dirname(outfile)
    cat("", file = outfile, append = append)
    cat(paste0(section, " `", results$name, "`"), section.sep,
        file = outfile, append = TRUE, sep = "")
    cat(paste0(results$title, section.sep), file = outfile,
        append = TRUE, sep = "\n")
    sections.print <- setdiff(names(results), c("name", "title"))
    for (i in sections.print[!sections.print %in% c("name",
                                                    "title")]) {
      if (i %in% names(results)) {
        cat(paste(subsection, i), section.sep,
            file = outfile, append = TRUE, sep = "")
        if (i %in% c("examples", "usage")) {
          cat("```{r}\n#| eval: false", paste(results[[i]], collapse = "\n"),
              "```", file = outfile, append = TRUE, sep = "\n")
        }
        else if (i == "arguments") {
          cat("Argument      |Description\n", file = outfile,
              append = TRUE)
          cat("------------- |----------------\n", file = outfile,
              append = TRUE)
          cat(paste0("`", names(results[[i]]), "`", "     |     ",
                     results[[i]], collapse = "\n"), file = outfile,
              append = TRUE, sep = "\n")
        }
        else {
          cat(paste0(results[[i]], collapse = "\n"),
              file = outfile, append = TRUE, sep = "\n")
        }
        cat(section.sep, file = outfile, append = TRUE)
      }
    }
  }
  else {
    warning("name and title are required. Not creating markdown file")
  }
  invisible(results)
}


