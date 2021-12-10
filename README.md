
<!-- README.md is generated from README.Rmd. Please edit that file -->

# paracorp

<!-- badges: start -->

[![R-CMD-check](https://github.com/gederajeg/paracorp/workflows/R-CMD-check/badge.svg)](https://github.com/gederajeg/paracorp/actions)
[![Codecov test
coverage](https://codecov.io/gh/gederajeg/paracorp/branch/main/graph/badge.svg)](https://app.codecov.io/gh/gederajeg/paracorp?branch=main)
[![](https://img.shields.io/badge/doi-10.17605/OSF.IO/HV9CU-lightblue.svg)](https://doi.org/10.17605/OSF.IO/HV9CU)
<!-- badges: end -->

The goal of **paracorp** is to provide an R functionality for generating
parallel concordance (Keyword-in-Context \[KWIC\] display) from a
parallel/bilingual corpora. The first attempt is implemented in the
`para_conc()` function that is built on top of the
[tidyverse](https://www.tidyverse.org/) suit of packages. Please use the
following citation if **paracorp** is used in publications:

``` r
citation("paracorp")
#> 
#> To cite `paracorp` in publications (in 'Unified style sheet for
#> linguistics' style) use:
#> 
#>   Rajeg, Gede Primahadi Wijaya. 2021. paracorp: A concordancer for
#>   parallel, bilingual corpora. R package.
#>   https://doi.org/10.17605/OSF.IO/HV9CU
#>   https://github.com/gederajeg/paracorp
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{rajeg_paracorp_2021,
#>     title = {paracorp: A concordancer for parallel, bilingual corpora},
#>     author = {Gede Primahadi Wijaya Rajeg},
#>     year = {2021},
#>     doi = {10.17605/OSF.IO/HV9CU},
#>     publisher = {GitHub and Open Science Framework (OSF)},
#>     url = {https://github.com/gederajeg/paracorp},
#>     note = {R package version 0.0.1},
#>   }
```

The **paracorp** package is part of the following [research
project](https://udayananetworking.unud.ac.id/lecturer/research/880-gede-primahadi-wijaya-rajeg/a-model-for-translation-study-based-on-english-indonesian-translation-database-and-its-pedagogical-implication-1179)
([Rajeg, Rajeg, Kartini, et al. 2021b](#ref-rajeg_material_2021)):

> Rajeg, Gede Primahadi Wijaya, I Made Rajeg, Putu Dea Indah Kartini & I
> Gede Semara Dharma Putra. 2021. Material pendukung untuk *MODEL KAJIAN
> TERJEMAHAN BERBASIS BANK DATA TERJEMAHAN DIGITAL INGGRIS-INDONESIA DAN
> IMPLIKASI PEDAGOGISNYA*. Open Science Framework.
> <https://doi.org/10.17605/OSF.IO/Y6ESA>. <https://osf.io/y6esa/>.

The output of the research has been disseminated in several seminars
([Rajeg, Rajeg, Kartini, et al. 2021a](#ref-rajeg_pemanfaatan_2021);
[Rajeg, Rajeg, Putra, et al. 2021](#ref-rajeg_derajat_2021)).

## Installation

You can install the development version of paracorp from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("gederajeg/paracorp")
```

## Example

The **paracorp** package comes with internal sample data of
English-Indonesian parallel corpora from the science genre developed by
the PAN BPPT project ([Adriani and Riza
2009](#ref-adriani_development_2009); [BPPT
2009](#ref-bppt_statistical_2009)). The data are available in the form
of character vectors called `sci_en` (for the English text) whose line
is aligned with the Indonesian version (`sci_id`).

The codes below shows how to generate a parallel concordance for the
English modal verb “should” as the target, search-term and present the
Indonesian translation (shown in the `TRANSLATION` column in the output
table).

``` r
library(paracorp) # load the package

# in this example, the English text is used as the source text
my_para_conc <- para_conc(source_text = sci_en, 
                          target_text = sci_id, 
                          pattern = "\\bshould\\b", # regular expression pattern
                          conc_sample = 20) # retrieve 20 random concordance lines
#> The output concordance file (called: 'parallel_conc.txt') will be saved in this directory: '/Users/Primahadi/Documents/r-packages/paracorp'
#> Detecting the match/pattern...
#> You choose to generate a 20 random-sample of the concordance lines.
#> Creating a 20 random-sample of the concordance lines...
#> Generating the concordance for the match/pattern...
#> Saving the output concordance file (called: 'parallel_conc.txt') in '/Users/Primahadi/Documents/r-packages/paracorp'.
head(my_para_conc)
#> # A tibble: 6 x 4
#>   LEFT                 NODE   RIGHT                  TRANSLATION                
#>   <chr>                <chr>  <chr>                  <chr>                      
#> 1 Very often there ar… should actually not be used … "Pemakaian granat gas seri…
#> 2 This enzyme should … should also react to the hol… "Enzim ini tentunya menjad…
#> 3 You                  should be able to control no… "Anda seharusnya dapat men…
#> 4 It                   should be admitted that init… "Perlu diakui bahwa untuk …
#> 5 The impression of d… should be changed             "Kesan menjijikan dan simb…
#> 6 To reach that, a co… should be created, either in… "Untuk menggapainya, harus…
```

The printed messages show that, by default, `para_conc()` also saves the
concordance into a tab-separated plain text (by default called
`'parallel_conc.txt'`). This file can be opened in MS Excel for further
corpus-based analyses.

You can also switch the position of the input corpora. In the example
below, the Indonesian text is considered as the source text and the
input string in the `pattern` argument of `para_conc()` represents the
Indonesian target, keyword.

``` r
# in this example, the Indonesian text is used as the source text
my_para_conc <- para_conc(source_text = sci_id, 
                          target_text = sci_en, 
                          pattern = "\\bseharusnya\\b", # regular expression pattern
                          conc_sample = 20) # retrieve 20 random concordance lines
#> The output concordance file (called: 'parallel_conc.txt') will be saved in this directory: '/Users/Primahadi/Documents/r-packages/paracorp'
#> Detecting the match/pattern...
#> You choose to generate a 20 random-sample of the concordance lines.
#> Creating a 20 random-sample of the concordance lines...
#> Generating the concordance for the match/pattern...
#> Saving the output concordance file (called: 'parallel_conc.txt') in '/Users/Primahadi/Documents/r-packages/paracorp'.
head(my_para_conc)
#> # A tibble: 6 x 4
#>   LEFT                  NODE    RIGHT                 TRANSLATION               
#>   <chr>                 <chr>   <chr>                 <chr>                     
#> 1 Main game menyebabka… seharu… , bahkan mungkin men… Playing game causes child…
#> 2 Lebih penting lagi, … seharu… ada dalam rekaman fo… More importantly, the rem…
#> 3 Bentuk peralihan yan… seharu… ada, mengapa kita ta… innumerable transitional …
#> 4 Adanya pendahulu-bur… seharu… benar-benar ada.      It is a purely hypothetic…
#> 5 Manusia memang        seharu… berkaca pada alam.    The mankind is supposed t…
#> 6 Anda                  seharu… dapat mengendalikan … You should be able to con…
```

Here is the R session info for this repository.

``` r
devtools::session_info()
#> ─ Session info ───────────────────────────────────────────────────────────────
#>  setting  value                       
#>  version  R version 4.0.5 (2021-03-31)
#>  os       macOS Big Sur 10.16         
#>  system   x86_64, darwin17.0          
#>  ui       X11                         
#>  language (EN)                        
#>  collate  en_US.UTF-8                 
#>  ctype    en_US.UTF-8                 
#>  tz       Asia/Makassar               
#>  date     2021-12-10                  
#> 
#> ─ Packages ───────────────────────────────────────────────────────────────────
#>  package     * version date       lib source        
#>  assertthat    0.2.1   2019-03-21 [1] CRAN (R 4.0.0)
#>  backports     1.1.7   2020-05-13 [1] CRAN (R 4.0.0)
#>  cachem        1.0.5   2021-05-15 [1] CRAN (R 4.0.2)
#>  callr         3.6.0   2021-03-28 [1] CRAN (R 4.0.2)
#>  cli           3.1.0   2021-10-27 [1] CRAN (R 4.0.2)
#>  crayon        1.4.1   2021-02-08 [1] CRAN (R 4.0.2)
#>  DBI           1.1.0   2019-12-15 [1] CRAN (R 4.0.0)
#>  desc          1.4.0   2021-09-28 [1] CRAN (R 4.0.2)
#>  devtools      2.4.3   2021-11-30 [1] CRAN (R 4.0.2)
#>  digest        0.6.25  2020-02-23 [1] CRAN (R 4.0.0)
#>  dplyr         1.0.5   2021-03-05 [1] CRAN (R 4.0.2)
#>  ellipsis      0.3.1   2020-05-15 [1] CRAN (R 4.0.0)
#>  evaluate      0.14    2019-05-28 [1] CRAN (R 4.0.0)
#>  fansi         0.4.1   2020-01-08 [1] CRAN (R 4.0.0)
#>  fastmap       1.1.0   2021-01-25 [1] CRAN (R 4.0.2)
#>  fs            1.5.1   2021-11-30 [1] CRAN (R 4.0.2)
#>  generics      0.0.2   2018-11-29 [1] CRAN (R 4.0.0)
#>  glue          1.4.1   2020-05-13 [1] CRAN (R 4.0.0)
#>  hms           1.0.0   2021-01-13 [1] CRAN (R 4.0.2)
#>  htmltools     0.5.2   2021-08-25 [1] CRAN (R 4.0.2)
#>  knitr         1.30    2020-09-22 [1] CRAN (R 4.0.2)
#>  lifecycle     1.0.0   2021-02-15 [1] CRAN (R 4.0.2)
#>  magrittr      2.0.1   2020-11-17 [1] CRAN (R 4.0.2)
#>  memoise       2.0.0   2021-01-26 [1] CRAN (R 4.0.2)
#>  paracorp    * 0.0.1   2021-12-10 [1] local         
#>  pillar        1.6.0   2021-04-13 [1] CRAN (R 4.0.2)
#>  pkgbuild      1.3.0   2021-12-09 [1] CRAN (R 4.0.5)
#>  pkgconfig     2.0.3   2019-09-22 [1] CRAN (R 4.0.0)
#>  pkgload       1.2.4   2021-11-30 [1] CRAN (R 4.0.2)
#>  prettyunits   1.1.1   2020-01-24 [1] CRAN (R 4.0.0)
#>  processx      3.5.1   2021-04-04 [1] CRAN (R 4.0.2)
#>  ps            1.6.0   2021-02-28 [1] CRAN (R 4.0.2)
#>  purrr         0.3.4   2020-04-17 [1] CRAN (R 4.0.0)
#>  R6            2.4.1   2019-11-12 [1] CRAN (R 4.0.0)
#>  readr         1.4.0   2020-10-05 [1] CRAN (R 4.0.2)
#>  remotes       2.4.2   2021-11-30 [1] CRAN (R 4.0.2)
#>  rlang         0.4.11  2021-04-30 [1] CRAN (R 4.0.2)
#>  rmarkdown     2.11    2021-09-14 [1] CRAN (R 4.0.2)
#>  rprojroot     1.3-2   2018-01-03 [1] CRAN (R 4.0.0)
#>  rstudioapi    0.13    2020-11-12 [1] CRAN (R 4.0.2)
#>  sessioninfo   1.1.1   2018-11-05 [1] CRAN (R 4.0.0)
#>  stringi       1.5.3   2020-09-09 [1] CRAN (R 4.0.2)
#>  stringr       1.4.0   2019-02-10 [1] CRAN (R 4.0.0)
#>  testthat      3.0.2   2021-02-14 [1] CRAN (R 4.0.2)
#>  tibble        3.1.0   2021-02-25 [1] CRAN (R 4.0.2)
#>  tidyselect    1.1.0   2020-05-11 [1] CRAN (R 4.0.0)
#>  usethis       2.1.3   2021-10-27 [1] CRAN (R 4.0.2)
#>  utf8          1.1.4   2018-05-24 [1] CRAN (R 4.0.0)
#>  vctrs         0.3.7   2021-03-29 [1] CRAN (R 4.0.2)
#>  withr         2.4.1   2021-01-26 [1] CRAN (R 4.0.2)
#>  xfun          0.22    2021-03-11 [1] CRAN (R 4.0.2)
#>  yaml          2.2.1   2020-02-01 [1] CRAN (R 4.0.0)
#> 
#> [1] /Users/Primahadi/Rlibs
#> [2] /Library/Frameworks/R.framework/Versions/4.0/Resources/library
```

## References

<div id="refs" class="references csl-bib-body hanging-indent">

<div id="ref-adriani_development_2009" class="csl-entry">

Adriani, Mirna, and Hammam Riza. 2009. “Development of Indonesian
Language Resources and Translation System.” PAN Localization Project on
Local Language Computing. Jakarta: University of Indonesia & Badan
Pengkajian dan Penerapan Teknologi (BPPT) (Agency for the Assessment and
Application of Technology)).
<http://www.panl10n.net/english/outputs/Indonesia/FinalReportID.pdf>.

</div>

<div id="ref-bppt_statistical_2009" class="csl-entry">

BPPT. 2009. “Statistical Machine Translation for Bahasa
Indonesia-English and English-Bahasa Indonesia.” PAN Localization
Project on Local Language Computing. Jakarta: Badan Pengkajian dan
Penerapan Teknologi (BPPT) (Agency for the Assessment and Application of
Technology)).
<http://www.panl10n.net/english/outputs/Indonesia/BPPT/0902/SMTFinalReport.pdf>.

</div>

<div id="ref-rajeg_pemanfaatan_2021" class="csl-entry">

Rajeg, Gede Primahadi Wijaya, I Made Rajeg, Putu Dea Indah Kartini, and
I Gede Semara Dharma Putra. 2021a. “Pemanfaatan Bank-Data Digital
Dwibahasa Dalam Kajian Terjemahan: Studi Kasus Padanan Bahasa Indonesia
Untuk Verba Sinonim Bahasa Inggris ROB & STEAL.” Paper.
<https://doi.org/10.6084/m9.figshare.17078369>.

</div>

<div id="ref-rajeg_material_2021" class="csl-entry">

———. 2021b. “Material Pendukung Untuk *MODEL KAJIAN TERJEMAHAN BERBASIS
BANK DATA TERJEMAHAN DIGITAL INGGRIS-INDONESIA DAN IMPLIKASI
PEDAGOGISNYA*,” November. <https://doi.org/10.17605/OSF.IO/Y6ESA>.

</div>

<div id="ref-rajeg_derajat_2021" class="csl-entry">

Rajeg, Gede Primahadi Wijaya, I Made Rajeg, I Gede Semara Dharma Putra,
and Putu Dea Indah Kartini. 2021. “Derajat Kesepadanan Konstruksional
Terjemahan Verba Bahasa Inggris *ROB* Dalam Bahasa Indonesia.” Paper.
<https://doi.org/10.6084/m9.figshare.17078384>.

</div>

</div>
