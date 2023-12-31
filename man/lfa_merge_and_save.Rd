% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/merge_and_save.R
\name{lfa_merge_and_save}
\alias{lfa_merge_and_save}
\title{Merge and Save Text Files in a Directory}
\usage{
lfa_merge_and_save(input_directory, output_name)
}
\arguments{
\item{input_directory}{The path to the input directory containing text files.}

\item{output_name}{The name for the output file where the merged content will be saved.}
}
\value{
This function does not explicitly return any value. It prints a message
indicating the successful completion of the merging and saving process.
}
\description{
This function takes an input directory and an output name as arguments.
It merges the textual content of all files in the specified directory into
a single string, with each file's content separated by a newline character.
The merged content is then saved into a file named after the output name
in the same directory. After the merging is complete, all input files are
deleted.
}
\details{
This function reads the content of each text file in the specified input directory
and concatenates them into a single string. Each file's content is separated by a newline
character. The merged content is then saved into a file named after the output name
in the same directory. Finally, all input files are deleted from the directory.
}
\examples{
# Merge text files in the "data_files" directory and save the result in "merged_output"
lfa_merge_and_save("data_files", "merged_output")

# Merge text files in the "data_files" directory and save the result in "merged_output"
lfa_merge_and_save("data_files", "merged_output")

}
\seealso{
\code{\link{readLines}}, \code{\link{writeLines}}, \code{\link{file.remove}}
}
