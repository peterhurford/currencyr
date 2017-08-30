exchange_rates <- memoise::memoise(function(base, as_of) {
  message("Downloading fresh exchange rates... May take a minute...")
  output <- httr::GET(currencyr:::get_fixer_url(base, as_of))
  status_code <- httr::status_code(output)
  if (!is.successful(status_code)) {
    stop("Error in fixer API - status code was ", status_code, "!")
  } else {
    httr::content(output)$rates
  }
})

exchange_rate <- memoise::memoise(ensure(
  post = list(result %is% numeric, length(result) == 1),
  function(from, to, as_of = NULL) {
    exchange_rates(from, as_of)[[to]]
  }))

get_fixer_url <- function(base = "USD", as_of = NULL) {
  if (length(as_of) == 0) { as_of <- "latest" }
  base <- toupper(base)
  paste0("http://api.fixer.io/", as_of, "?base=", base)
}

is.successful <- function(status_code) {
  status_code >= 200 && status_code < 300
}
