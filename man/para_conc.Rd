% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/para_conc.R
\name{para_conc}
\alias{para_conc}
\title{Parallel concordance}
\usage{
para_conc(
  source_text = "The source text corpus",
  target_text = "The target text corpus",
  pattern = "Search pattern for words in the source text",
  case_insensitive = FALSE,
  conc_sample = 25,
  filename = "parallel_conc.txt"
)
}
\arguments{
\item{source_text}{character vector of the source-text corpora}

\item{target_text}{character vector of the target-text corpora}

\item{pattern}{regular expression search pattern for the source-text node word}

\item{case_insensitive}{logical; whether the search pattern is case insensitive. Default to FALSE}

\item{conc_sample}{random sample of the concordance lines}

\item{filename}{file name of the parallel concordance output}
}
\value{
A tibble of parallel concordance with source-text node word and its left and right context, and their target-text translation. By default, \code{para_conc()} also automatically saves the concordance into a tab-separated plain text named \code{"parallel_conc.txt"}. Users can specify their own output file name.
}
\description{
A function to generate a concordance from parallel, bilingual corpora.
}
\examples{
para_conc(sci_en, sci_id, pattern = "should", conc_sample = 20)
          # we delete the automatic output file to remove warning in R CMD check
          unlink("parallel_conc.txt")

          # example when automatic output file is suppressed with filename = FALSE
          # and only producing a tibble/data frame.
          para_conc(sci_en, sci_id,
                    pattern = "should",
                    conc_sample = 20,
                    filename = FALSE) # suppress automatic output
}
