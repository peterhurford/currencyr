context("currency_codes")

test_that("it returns codes", {
  expect_true(is.character(currency_codes()))
  expect_true("USD" %in% currency_codes())
})

test_that("it gets the unit from the code", {
  expect_equal("American Dollar", get_unit_from_code("USD"))
  expect_equal("Canadian Dollar", get_unit_from_code("CAD"))
})
