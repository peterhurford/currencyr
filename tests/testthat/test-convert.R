context("convert")

test_that("it quickchecks USD to USD", {
  with_mock(`currencyr:::exchange_rate` = function(from, to) {
      stop("Fixer should not be called in this simple example!")
    }, {
    checkr::quickcheck(checkr::ensure(
      pre = list(amount %is% numeric, length(amount) == 1),
      post = list(
        all(c("value", "unit", "code", "exchange_rate") %in% names(result)),
        identical(result$value, round(amount, 2)),
        identical(result$unit, "American Dollar"),
        identical(result$exchange_rate, 1),
        identical(result$code, "USD")),
      function(amount) { convert(amount, from = "USD", to = "USD") }))
  })
})

test_that("it quickchecks CAD to CAD", {
  with_mock(`currencyr:::exchange_rate` = function(from, to) {
      stop("Fixer should not be called in this simple example!")
    }, {
    checkr::quickcheck(checkr::ensure(
      pre = list(amount %is% numeric, length(amount) == 1),
      post = list(
        identical(result$value, round(amount, 2)),
        identical(result$unit, "Canadian Dollar"),
        identical(result$exchange_rate, 1),
        identical(result$code, "CAD")),
      function(amount) { convert(amount, from = "CAD", to = "CAD") }))
  })
})

test_that("it quickchecks USD to CAD", {
  with_mock(`currencyr:::exchange_rate` = function(from, to, as_of = NULL) {
              if (identical(to, "CAD")) { 0.5 } else { stop("Invalid code!") }
            },
            `currencyr:::exchange_rates` = function(as_of) { stop("Should not be called!") }, {
    checkr::quickcheck(checkr::ensure(
      pre = list(amount %is% numeric, length(amount) == 1),
      post = list(
        identical(result$value, round(amount / 2, 2)),
        identical(result$unit, "Canadian Dollar"),
        identical(result$exchange_rate, 0.5),
        identical(result$code, "CAD")),
      function(amount) { convert(amount, from = "USD", to = "CAD") }))
  })
})

test_that("it quickchecks USD to EUR", {
  with_mock(`currencyr:::exchange_rate` = function(from, to, as_of = NULL) {
              if (identical(to, "EUR")) { 2 } else { stop("Invalid code!") }
            },
            `currencyr:::exchange_rates` = function(as_of) { stop("Should not be called!") }, {
    checkr::quickcheck(checkr::ensure(
      pre = list(amount %is% numeric, length(amount) == 1),
      post = list(
        identical(result$value, round(amount * 2, 2)),
        identical(result$unit, "Euro"),
        identical(result$exchange_rate, 2),
        identical(result$code, "EUR")),
      function(amount) { convert(amount, from = "USD", to = "EUR") }))
  })
})

test_that("it rounds", {
  expect_equal(68.12, convert(68.123456)$value)
  expect_equal(68.99, convert(68.987654)$value)
})

test_that("it prints", {
  expect_output(print(convert(68)), "68 American Dollar")
  expect_output(print(convert(68, from = "EUR", to = "EUR")), "68 Euro")
})

test_that("as_of must be yyyy-mm-dd", {
  expect_error(convert(68, from = "USD", to = "EUR", as_of = "pizza"), "yyyy-mm-dd format")
})

test_that("as_of older than 2000 is not supported", {
  expect_error(convert(68, from = "USD", to = "EUR", as_of = "1991-12-11"), "not supported")
})

test_that("time travel not supported", {
  expect_error(convert(68, from = "USD", to = "EUR", as_of = "4991-12-11"), "time travel")
})

test_that("it quickchecks USD to EUR with as_of", {
  with_mock(`currencyr:::exchange_rate` = function(from, to, as_of) {
              if (identical(to, "EUR")) { 2 } else { stop("Invalid code!") }
            },
            `currencyr:::exchange_rates` = function(as_of) { stop("Should not be called!") }, {
    checkr::quickcheck(checkr::ensure(
      pre = list(amount %is% numeric, length(amount) == 1),
      post = list(
        identical(result$value, round(amount * 2, 2)),
        identical(result$unit, "Euro"),
        identical(result$exchange_rate, 2),
        identical(result$code, "EUR")),
      function(amount) { convert(amount, from = "USD", to = "EUR", as_of = "2017-01-12") }))
  })
})

# TODO: quickcheck with date strings.
# TODO: test as_of = "today" and as_of = "latest"
