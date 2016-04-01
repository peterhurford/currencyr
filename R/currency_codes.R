currency_map <- memoise::memoise(function() {
  list(
    list("USD", "American Dollar"),
    list("CAD", "Candian Dollar"),
    list("EUR", "Euro")
  )})

currency_codes <- memoise::memoise(
  checkr::ensure(post = list(result %is% vector, result %contains_only% simple_string),
  function() {
    unlist(lapply(currency_map(), `[[`, 1))
  }))
