currency_map <- memoise::memoise(function() {
  list(
    "AUD" = "Australian Dollar",
    "CAD" = "Canadian Dollar",
    "CHF" = "Swiss Franc",
    "CNY" = "Chinese Yuan",
    "CZK" = "Czech Crown",
    "DKK" = "Danish Krone",
    "EUR" = "Euro",
    "GBP" = "British Pound",
    "HRK" = "Croatian Kuna",
    "HUF" = "Hungarian Forint",
    "INR" = "Indian Rupee",
    "JPY" = "Japanese Yen",
    "MEX" = "Mexican Peso",
    "MYR" = "Malaysian Ringgit",
    "NZD" = "New Zealand Dollars",
    "NOK" = "Norwegian Krone",
    "PLN" = "Polish Zloty",
    "BRL" = "Brazillian Real",
    "RUB" = "Russian Ruble",
    "SEK" = "Swedish Krona",
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
