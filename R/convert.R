#' Convert a currency into another currency.
#'
#' @param amount numeric. The amount to convert.
#' @param from character. The currency code to convert from. Defaults to \code{USD}.
#' @param to character. The currency code to convert to. Defaults to \code{USD}.
#' @return the amount in the converted currency.
#' @import checkr
#' @export
convert <- checkr::ensure(
  pre = list(
    amount %is% numeric, length(amount) == 1,
    from %in% currencyr:::currency_codes(),
    to %in% currencyr:::currency_codes(),
    as_of %is% character || as_of %is% NULL,
    length(as_of) %within% c(0, 1)),
  post = list(
    result %is% currency
  ),
  function(amount, from = "USD", to = "USD", as_of = NULL) {
    if (identical(as_of, "today") || identical(as_of, "latest")) { as_of <- NULL }
    if (length(as_of) == 1) {
      as_of <- suppressWarnings(lubridate::ymd(as_of))
      if (is.na(as_of)) {
        stop(sQuote("as_of"), " parameter must be in yyyy-mm-dd format")
      }
      if (lubridate::year(as_of) < 2000) {
        stop(sQuote("as_of"), " older than 2000 is not supported.")
      }
      if (as_of > lubridate::ymd(Sys.Date())) {
        stop(sQuote("as_of"), " in the future doesn't work, as time travel is not yet supported.")
      }
    }
    exchange_rate <- if (identical(from, to)) {
      1
    } else {
      currencyr:::exchange_rate(from, to, as_of)
    }
    result <- list(
      value = round(amount * exchange_rate, 2),
      unit = currencyr:::get_unit_from_code(to),
      exchange_rate = exchange_rate,
      code = to)
    if (length(as_of) == 1) { result$as_of <- as_of }
    class(result) <- "currency"
    result
  })


#' Print for currency objects
#' @param x currency. The currency object to print.
#' @param ... list. Additional arguments to pass to print.
print.currency <- function(x, ...) {
  print(paste(round(x$value, 2), x$unit), ...)
}

#' @aliases convert
currency <- convert
