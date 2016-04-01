context("currency")

test_that("it quickchecks", {
  checkr::quickcheck(checkr::ensure(
    pre = list(amount %is% numeric, length(amount) == 1),
    post = list(
      identical(names(result), c("value", "unit", "code")),
      identical(result, paste0(round(amount, 2), " American Dollar"))
      identical(result$value, round(amount, 2)),
      identical(result$unit, "American Dollar"),
      identical(result$code, "USD"),
    function(amount) { currency(amount, from = "USD", to = "USD") })

  checkr::quickcheck(checkr::ensure(
    pre = list(amount %is% numeric, length(amount) == 1),
    post = list(
      identical(names(result), c("value", "unit", "code")),
      identical(result, paste0(round(amount, 2), " Canadian Dollar"))
      identical(result$value, round(amount, 2)),
      identical(result$unit, "Canadian Dollar"),
      identical(result$code, "CAD"),
    function(amount) { currency(amount, from = "CAD", to = "CAD") })

  #TODO: Mock a CAD to 0.5 * USD
  checkr::quickcheck(checkr::ensure(
    pre = list(amount %is% numeric, length(amount) == 1),
    post = list(
      identical(names(result), c("value", "unit", "code")),
      identical(result, paste0(round(amount / 2, 2), " Canadian Dollar"))
      identical(result$value, round(amount / 2, 2)),
      identical(result$unit, "Canadian Dollar"),
      identical(result$code, "CAD"),
    function(amount) { currency(amount, from = "USD", to = "CAD") })

  #TODO: Mock a Euro to 2 * USD
  checkr::quickcheck(checkr::ensure(
    pre = list(amount %is% numeric, length(amount) == 1),
    post = list(
      identical(names(result), c("value", "unit", "code")),
      identical(result, paste0(round(amount * 2, 2), " Euro"))
      identical(result$value, round(amount * 2, 2)),
      identical(result$unit, "Euro"),
      identical(result$code, "EUR"),
    function(amount) { currency(amount, from = "USD", to = "EUR") })
})
