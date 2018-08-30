exchange_rates <- memoise::memoise(function(as_of, api_key = "") {
  if (!checkr::is.simple_string(api_key)) {
    stop("You must get an API key from www.fixer.io for this service to work. Please ",
         "register for a key and then set `export FIXER_KEY=xxxxxx` as an environment ",
         "variable before using this service.")
  }
  if (length(as_of) == 1 && lubridate::ymd(Sys.Date()) != lubridate::ymd(as_of)) {
    message("Downloading historical exchange rates as of ", as_of, "... May take a minute...")
  } else {
    message("Downloading fresh exchange rates... May take a minute...")
  }
  output <- httr::GET(currencyr:::get_fixer_url(as_of, api_key))
  status_code <- httr::status_code(output)
  if (!is.successful(status_code)) {
    stop("Error in fixer API - status code was ", status_code, "!")
  } else {
    httr::content(output)$rates
  }
})

exchange_rate <- ensure(
  post = list(result %is% numeric, length(result) == 1),
  function(from, to, as_of = NULL, api_key = "") {
    rates <- exchange_rates(as_of = as_of, api_key = api_key)
    if (identical(from, "EUR")) {  # Free Fixer is stuck in EUR
      rates[[to]]
    } else if (identical(to, "EUR")) {
      1 / rates[[from]]
    } else {
      # Convert `from` to EUR
      from_rate <- 1 / rates[[from]]
      # Convert `from_rate` (EUR) to `to`.
      to_rate <- rates[[to]]
      # Create rate, converting to EUR in between
      from_rate * to_rate
    }
  })

get_fixer_url <- function(as_of = NULL, api_key = "") {
  if (!checkr::is.simple_string(as_of)) { as_of <- "latest" }
  paste0("http://api.fixer.io/", as_of, "?access_key=", api_key)
}

is.successful <- function(status_code) {
  status_code >= 200 && status_code < 300
}
