context("exchange_rate")

test_that("it needs an API key", {
  with_mock(
    `httr::GET` = function(...) { NULL },
    `httr::content` = function(...) { NULL },
    `httr::status_code` = function(...) 200L,
    expect_error(exchange_rate("USD", "EUR", api_key = ""),
                 "You must get an API key"))
})

test_that("it error handles", {
  with_mock(
    `httr::GET` = function(...) { NULL },
    `httr::content` = function(...) { NULL },
    `httr::status_code` = function(...) 500L,
    expect_error(exchange_rate("USD", "EUR", api_key = "key"),
                 "Error in fixer API - status code was 500!"))
})

test_that("it returns content", {
  with_mock(
    `httr::GET` = function(...) { NULL },
    `httr::content` = function(...) { list(rates = list(EUR = 200)) },
    `httr::status_code` = function(...) 200L,
    expect_equal(200, exchange_rate("USD", "EUR", api_key = "key"))
  )
})

# TODO: Test memoization

test_that("get_fixer_url", {
  expect_equal("http://api.fixer.io/latest?access_key=", get_fixer_url())
})

test_that("get_fixer_url handles as_of", {
  expect_equal("http://api.fixer.io/2017-12-11?access_key=",
    get_fixer_url(lubridate::ymd("2017-12-11")))
})
