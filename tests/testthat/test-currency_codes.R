context("currency_codes")

test_that("it returns codes", {
  expect_true(is.character(currency_codes()))
  expect_true("USD" %in% currency_codes())
})

test_that("it gets the unit from the code", {
  expect_equal("American Dollar", get_unit_from_code("USD"))
  expect_equal("Canadian Dollar", get_unit_from_code("CAD"))
})

test_that("it gets the code from the unit", {
  expect_equal("USD", get_code_from_unit("American Dollar"))
  expect_equal("CAD", get_code_from_unit("Canadian Dollar"))
})

test_that("it can fuzzy match a code from the unit", {
  expect_equal("USD", get_code_from_unit("american"))
  expect_equal("BRL", get_code_from_unit("real"))
})
