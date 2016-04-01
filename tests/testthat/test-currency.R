context("currency")

test_that("it quickchecks USD to USD", {
  with_mock(`currencyr:::fixer` = function(from, to) {
      stop("Fixer should not be called in this simple example!")
    }, {
    checkr::quickcheck(checkr::ensure(
      pre = list(amount %is% numeric, length(amount) == 1),
      post = list(
        identical(names(result), c("value", "unit", "code")),
        identical(result$value, round(amount, 2)),
        identical(result$unit, "American Dollar"),
        identical(result$code, "USD")),
      function(amount) { currency(amount, from = "USD", to = "USD") }))
  })
})

test_that("it quickchecks CAD to CAD", {
  with_mock(`currencyr:::fixer` = function(from, to) {
      stop("Fixer should not be called in this simple example!")
    }, {
    checkr::quickcheck(checkr::ensure(
      pre = list(amount %is% numeric, length(amount) == 1),
      post = list(
        identical(names(result), c("value", "unit", "code")),
        identical(result$value, round(amount, 2)),
        identical(result$unit, "Canadian Dollar"),
        identical(result$code, "CAD")),
      function(amount) { currency(amount, from = "CAD", to = "CAD") }))
  })
})

test_that("it quickchecks USD to CAD", {
  with_mock(`currencyr:::fixer` = function(from, to) {
      if (identical(to, "CAD")) { 0.5 } else { stop("Invalid code!") }
    }, {
    checkr::quickcheck(checkr::ensure(
      pre = list(amount %is% numeric, length(amount) == 1),
      post = list(
        identical(names(result), c("value", "unit", "code")),
        identical(result$value, round(amount / 2, 2)),
        identical(result$unit, "Canadian Dollar"),
        identical(result$code, "CAD")),
      function(amount) { currency(amount, from = "USD", to = "CAD") }))
  })
})

test_that("it quickchecks USD to EUR", {
  with_mock(`currencyr:::fixer` = function(from, to) {
      if (identical(to, "EUR")) { 2 } else { stop("Invalid code!") }
    }, {
    checkr::quickcheck(checkr::ensure(
      pre = list(amount %is% numeric, length(amount) == 1),
      post = list(
        identical(names(result), c("value", "unit", "code")),
        identical(result$value, round(amount * 2, 2)),
        identical(result$unit, "Euro"),
        identical(result$code, "EUR")),
      function(amount) { currency(amount, from = "USD", to = "EUR") }))
  })
})

test_that("it prints", {
  expect_output(print(currency(68)), "68 American Dollar")
  expect_output(print(currency(68, from = "EUR", to = "EUR")), "68 Euro")
})
