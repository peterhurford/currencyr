exchange_rate <- memoise::memoise(ensure(
  post = list(result %is% numeric, length(result) == 1),
  function(from, to) {
    output <- httr::GET(currencyr:::get_fixer_url(from, to))
    status_code <- httr::status_code(output)
    if (!is.successful(status_code)) {
      stop("Error in fixer API - status code was ", status_code, "!")
    } else {
      httr::content(output)$rates[[to]]
    }
  }))

get_fixer_url <- function(from, to) {
  from <- toupper(from)
  to <- toupper(to)
  # if we're converting from USD to EUR, the symbol should be USD and the base should be EUR
  paste0("http://api.fixer.io/latest?symbols=", to, "&base=", from)
}

is.successful <- function(status_code) {
  status_code >= 200 && status_code < 300
}