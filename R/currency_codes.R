currency_map <- memoise::memoise(function() {
  list(
    list("USD", "American Dollar"),
    list("CAD", "Canadian Dollar"),
    list("EUR", "Euro")
  )})

currency_codes <- memoise::memoise(
  checkr::ensure(post = list(result %is% vector, result %contains_only% simple_string),
  function() {
    unlist(lapply(currency_map(), `[[`, 1))
  }))

get_unit_from_code <- function(code) {
  Find(function(x) identical(x[[1]], code), currency_map())[[2]]
}
