#' Parallel concordance
#'
#' @param source_text character vector of the source-text corpora
#' @param target_text character vector of the target-text corpora
#' @param pattern regular expression search pattern for the source-text node word
#' @param case_insensitive logical; whether the search pattern is case insensitive. Default to FALSE
#' @param conc_sample random sample of the concordance lines
#' @param filename file name of the parallel concordance output
#'
#' @return A tibble of parallel concordance with source-text node word and its left and right context, and their target-text translation
#' @export
#' @importFrom rlang .data
#' @importFrom dplyr arrange
#' @importFrom dplyr bind_rows
#' @importFrom dplyr desc
#' @importFrom dplyr mutate
#' @importFrom purrr map
#' @importFrom purrr map_df
#' @importFrom readr write_tsv
#' @importFrom stringr regex
#' @importFrom stringr str_which
#' @importFrom stringr str_locate_all
#' @importFrom stringr str_count
#' @importFrom stringr str_sub
#' @importFrom stringr str_trim
#' @importFrom stringr str_c
#' @importFrom stringr str_replace
#' @importFrom tibble tibble
#'
#' @examples para_conc(sci_en, sci_id, pattern = "should", conc_sample = 20)
#'           # we delete the output file to remove warning in R CMD check
#'           unlink("parallel_conc.txt")
para_conc <- function(source_text = "The source text corpus",
                      target_text = "The target text corpus",
                      pattern = "Search pattern for words in the source text",
                      case_insensitive = FALSE,
                      conc_sample = 25,
                      filename = "parallel_conc.txt") {

  m_st <- source_text; rm(source_text)
  m_tt <- target_text; rm(target_text)

  search_term <- pattern
  samples <- conc_sample

  message(paste("The output concordance file (called: '", filename,"') will be saved in this directory: '", getwd(), "'\n", sep = ""))

  cat("LEFT\tNODE\tRIGHT\tTRANSLATION", file = filename, sep = "\n")

  for (i in seq_along(search_term)) {

    m_id <- stringr::str_which(m_st, stringr::regex(search_term[i], ignore_case = case_insensitive))

    if ((length(m_id) >= 1) == TRUE) {

      m <- m_st[m_id]
      message("Detecting the match/pattern...\n")
      m_loc <- stringr::str_locate_all(m, stringr::regex(search_term[i], ignore_case = case_insensitive))
      m_loc <- purrr::map(m_loc, tibble::as_tibble)
      m_loc <- purrr::map_df(m_loc, dplyr::bind_rows)

      # duplicate the number of subset text as many as the number of the match
      m1 <- rep(m, stringr::str_count(m, stringr::regex(search_term[i], ignore_case = case_insensitive)))
      m_id <- rep(m_id, stringr::str_count(m, stringr::regex(search_term[i], ignore_case = case_insensitive)))

      if (samples) {

        message(paste("You choose to generate a ", samples, " random-sample of the concordance lines.\n", sep = ""))
        message(paste("Creating a ", samples, " random-sample of the concordance lines...\n", sep = ""))

        # sample count
        sample_count <- sample(1:length(m1), samples)

        # retrieve random sample sentences
        st_sample <- m1[sample_count]
        tt_sample <- m_tt[m_id[sample_count]]
        m_loc1 <- m_loc[sample_count, ]

      } else {

        message("Retrieving all occurrences of the search pattern...\n")

        st_sample <- m1
        tt_sample <- m_tt[m_id]
        m_loc1 <- m_loc

      }

      # extract match
      message("Generating the concordance for the match/pattern...\n")
      node <- stringr::str_sub(st_sample, start = m_loc1$start, end = m_loc1$end)
      node_tag <- stringr::str_c("\t<NODE>", node, "</NODE>\t", sep = "")
      left <- stringr::str_sub(st_sample, start = 1, end = (m_loc1$start - 1))
      right <- stringr::str_sub(st_sample, start = (m_loc1$end + 1), end = nchar(st_sample))

      # create concordance
      # LEFT <- stringr::str_sub(left, start = (nchar(left) - context_char), end = nchar(left))
      LEFT <- replace(left, nchar(left) == 0, "~")
      NODE <- node
      # RIGHT <- stringr::str_sub(right, start = 1, end = context_char)
      RIGHT <- replace(right, nchar(right) == 0, "~")
      TRANSLATION <- tt_sample
      concord_df <- tibble::tibble(LEFT, NODE, RIGHT, TRANSLATION)
      concord_df <- dplyr::mutate(concord_df,
                                  LEFT = stringr::str_trim(.data$LEFT),
                                  NODE = stringr::str_trim(.data$NODE),
                                  RIGHT = stringr::str_trim(.data$RIGHT))
      concord_df <- dplyr::mutate(concord_df,
                                  LEFT = stringr::str_replace(LEFT, "^-", '"-'),
                                  RIGHT = stringr::str_replace(RIGHT, "^-", '"-'),
                                  TRANSLATION = stringr::str_replace(TRANSLATION, "^-", '"-'))

      message(paste("Saving the output concordance file (called: '", filename,"') in '", getwd(), "'.\n", sep = ""))

      readr::write_tsv(dplyr::arrange(concord_df, dplyr::desc(NODE), RIGHT), filename, append = TRUE)

      return(dplyr::arrange(concord_df, dplyr::desc(NODE), RIGHT))

    } else {

      message("Sorry; no match found! Try another corpus/pattern!\n")

    }

  }

}
