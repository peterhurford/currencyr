#' A map of currency codes to their units.
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

#' Get the currency codes from the currency map.
#' @import checkr
#' @export
currency_codes <- memoise::memoise(checkr::ensure(
  post = list(result %is% vector, result %contains_only% simple_string),
  function() {
    unlist(names(currencyr:::currency_map()))
  }))

#' Get a unit from a currency code.
#' @param code character. The currency code to use.
#' @import checkr
#' @export
get_unit_from_code <- checkr::ensure(
  pre = code %in% currencyr:::currency_codes(),
  post = result %is% simple_string,
  function(code) {
    currencyr:::currency_map()[[code]]
  })

#' Get the currency code from a unit, using fuzzy matching.
#' @param unit character. The currency unit to try.
#' @import checkr
#' @export
get_code_from_unit <- checkr::ensure(
  pre = unit %is% simple_string,
  post = result %in% currencyr:::currency_codes(),
  function(unit) {
    names(currencyr:::currency_map())[grep(tolower(unit),
      lapply(currencyr:::currency_map(), tolower))]
  })
