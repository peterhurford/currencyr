currency_map <- memoise::memoise(function() {
  list(
    "AUD" = "Australian Dollar",
    "CAD" = "Canadian Dollar",
    "CHF" = "Swiss Franc",
    "CNY" = "Chinese Yuan",
    "CZK" = "Czech Crown",
    "DKK" = "",
    "EUR" = "Euro",
    "GBP" = "British Pound",
    "HRK" = "",
    "HUF" = "",
    "INR" = "",
    "JPY" = "",
    "MEX" = "",
    "MYR" = "Malaysian Ringgit",
    "NZD" = "New Zealand Dollars",
    "NOK" = "Norwegian Krone",
    "PLN" = "",
    "BRL" = "Brazillian Real",
    "RUB" = "",
    "SEK" = "",
    "SGD" = "Singapore Dollar",
    "TRY" = "Turkish Lira",
    "USD" = "American Dollar",
    "ZAR" = "South African Rands"
  )})

currency_codes <- memoise::memoise(
  checkr::ensure(post = list(result %is% vector, result %contains_only% simple_string),
  function() {
    unlist(names(currency_map()))
  }))

get_unit_from_code <- function(code) {
  currency_map()[[code]]
}

get_code_from_unit <- function(unit) {
  names(currency_map())[grep(tolower(unit), lapply(currency_map(), tolower))]
}
