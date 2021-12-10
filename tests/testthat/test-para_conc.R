test_that("para_conc() works and generating messages", {
  expect_output(str(para_conc(sci_en, sci_id, pattern = "should")), "tbl_df")
})
unlink("parallel_conc.txt")

my_para_conc_eng <- para_conc(sci_en, sci_id, pattern = "should", conc_sample = FALSE)
test_that("para_conc() works and generating messages", {
  expect_output(str(my_para_conc_eng), "tbl_df")
  expect_match(unique(my_para_conc_eng$NODE), "should")
})
unlink("parallel_conc.txt")

my_para_conc <- para_conc(sci_id, sci_en, pattern = "\\bseharusnya\\b", conc_sample = FALSE)
test_that("para_conc() works when the source and target texts are switched", {
  expect_output(str(my_para_conc), "tbl_df")
  expect_match(unique(my_para_conc$NODE), "seharusnya")
})
unlink("parallel_conc.txt")

test_that("para_conc() works and generating messages", {
  expect_message(str(para_conc(sci_en, sci_id, pattern = "sadfkadfjds;fld;saf", conc_sample = FALSE)), "no match found")
})
unlink("parallel_conc.txt")
