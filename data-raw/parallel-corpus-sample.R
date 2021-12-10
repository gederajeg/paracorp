## code to prepare sample data for the parallel corpora dataset goes here

## we use the BPPT corpus as examples; see the reference below for citation:

## BPPT. (2009). Statistical machine translation for Bahasa Indonesia-English and English-Bahasa Indonesia (PAN Localization Project on Local Language Computing). Badan Pengkajian dan Penerapan Teknologi (BPPT) (Agency for the Assessment and Application of Technology)). http://www.panl10n.net/english/outputs/Indonesia/BPPT/0902/SMTFinalReport.pdf

## The original URL is no longer available but the corpus is now uploaded at https://github.com/prasastoadi/parallel-corpora-en-id

library(tidyverse)

sci_id <- readr::read_lines("/Users/Primahadi/Documents/AntConc/antconc-tuts/PANL-BPPT-SCI-ID-100Kw.txt")
sci_en <- readr::read_lines("/Users/Primahadi/Documents/AntConc/antconc-tuts/PANL-BPPT-SCI-EN-100Kw.txt")


usethis::use_data(sci_id, compress = "xz", overwrite = TRUE)
usethis::use_data(sci_en, compress = "xz", overwrite = TRUE)
