#' Convert a currency into another currency.
#'
#' @param amount numeric. The amount to convert.
#' @param from character. The currency code to convert from. Defaults to \code{USD}.
#' @param to character. The currency code to convert to. Defaults to \code{USD}.
#' @returns the amount in the converted currency.
#' @import checkr
#' @export
currency <- checkr::ensure(
  pre = list(
    amount %is% numeric, length(amount) == 1,
    from %in% currency_codes(),
    to %in% currency_codes()),
  post = list(
    result %is% currency
  ),
  function(amount, from = "USD", to = "USD") {
    exchange_rate <- if (identical(from, to)) { 1 } else { fixer(from, to) }
    result <- list(
      value = amount * exchange_rate,
      unit = get_unit_from_code(to),
      code = to)
    class(result) <- "currency"
    result
  })


#' Print for currency objects
#' @param x currency. The currency object to print.
#' @param ... list. Additional arguments to pass to print.
print.currency <- function(x, ...) {
   print(paste(round(x$value, 2), x$unit), ...)
}
