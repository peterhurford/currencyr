context("currency_codes")

test_that("it quickchecks", {
  checkr::quickcheck(currency_codes)
  expect_true("USD" %in% currency_codes())
})
