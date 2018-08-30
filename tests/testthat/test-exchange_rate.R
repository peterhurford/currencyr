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
  expect_equal("http://api.fixer.io/latest?base=USD&access_key=", get_fixer_url("USD"))
})

test_that("get_fixer_url upcases", {
  expect_equal("http://api.fixer.io/latest?base=EUR&access_key=", get_fixer_url("eur"))
})

test_that("get_fixer_url handles as_of", {
  expect_equal("http://api.fixer.io/2017-12-11?base=CAD&access_key=",
    get_fixer_url("cad", as_of = lubridate::ymd("2017-12-11")))
})
