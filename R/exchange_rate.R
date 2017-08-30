exchange_rates <- memoise::memoise(function(as_of) {
  message("Downloading fresh exchange rates... May take a minute...")
  output <- httr::GET(currencyr:::get_fixer_url(base = "USD", as_of))
  status_code <- httr::status_code(output)
  if (!is.successful(status_code)) {
    stop("Error in fixer API - status code was ", status_code, "!")
  } else {
    httr::content(output)$rates
  }
})

exchange_rate <- ensure(
  post = list(result %is% numeric, length(result) == 1),
  function(from, to, as_of = NULL) {
    rates <- exchange_rates(as_of)
    if (identical(from, "USD")) {
      rates[[to]]
    } else if (identical(to, "USD")) {
      1 / rates[[from]]
    } else {
      # Convert `from` to USD
      from_rate <- 1 / rates[[from]]
      # Convert `from_rate` (USD) to `to`.
      to_rate <- rates[[to]]
      # Create rate, converting to USD in between
      from_rate * to_rate
    }
  })

get_fixer_url <- function(base = "USD", as_of = NULL) {
  if (length(as_of) == 0) { as_of <- "latest" }
  base <- toupper(base)
  paste0("http://api.fixer.io/", as_of, "?base=", base)
}

is.successful <- function(status_code) {
  status_code >= 200 && status_code < 300
}
