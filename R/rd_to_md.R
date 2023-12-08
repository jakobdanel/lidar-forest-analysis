#' @export
lfa_rd_to_md <- function(rdfile, outfile, append = FALSE)
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
  file.ext <- "md"
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


#' @export
lfa_rd_to_results <- function() {
  # find all files
  file.remove(file.path(getwd(),"results","appendix","package-docs","docs.qmd"))
  files <- list.files(path = "./man/", pattern = ".Rd", full.names = "FALSE")
  names <- tools::file_path_sans_ext(files)
  in_path <- file.path(getwd(),"man",files)
  out_path <- file.path(getwd(),"results","appendix","package-docs",paste0(names,".qmd"))
  for(i in 1:length(in_path)){
    if(file.exists(out_path[i])){
      file.remove(out_path[i])
    }
    lfa_rd_to_md(in_path[i],out_path[i])
  }
  lfa_merge_and_save(file.path(getwd(),"results","appendix","package-docs"),"docs.qmd")
}


#' @export
lfa_merge_and_save <- function(input_directory, output_name) {
  # Check if the input directory exists
  if (!file.exists(input_directory) || !file.info(input_directory)$isdir) {
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
  merged_content <- head(merged_content, -1)

  # Concatenate the lines with a newline character
  merged_content <- paste(merged_content, collapse = "\n")

  # Save the merged content to a file in the same directory
  output_path <- file.path(input_directory, output_name)
  writeLines(merged_content, con = output_path)

  # Delete all input files
  file.remove(files)

  cat("Merging and saving completed successfully.\n")
}

# Example usage:
# Replace 'input_directory' and 'output_name' with your desired values
# merge_and_save("path/to/your/input/directory", "output_file_name")


# Example usage:
# Replace 'input_directory' and 'output_name' with your desired values
# merge_and_save("path/to/your/input/directory", "output_file_name")

