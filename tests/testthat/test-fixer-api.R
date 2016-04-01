context("fixer-api")

test_that("it error handles", {
  with_mock(
    `httr::GET` = function(...) { NULL },
    `httr::content` = function(...) { NULL },
    `httr::status_code` = function(...) 500L,
    expect_error(fixer("USD", "EUR"), "Error in fixer API - status code was 500!"))
})

test_that("it returns content", {
  with_mock(
    `httr::GET` = function(...) { NULL },
    `httr::content` = function(...) { list(rates = list(USD = 200)) },
    `httr::status_code` = function(...) 200L,
    expect_equal(200, fixer("USD", "EUR"))
  )
})

test_that("get_fixer_url", {
  expect_equal("http://api.fixer.io/latest?symbols=USD&base=EUR",
    get_fixer_url("USD", "EUR"))
})

test_that("get_fixer_url upcases", {
  expect_equal("http://api.fixer.io/latest?symbols=USD&base=EUR",
    get_fixer_url("usd", "eur"))
})
