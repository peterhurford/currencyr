currency_map <- memoise::memoise(function() {
  list(
    list("USD", "American Dollar")
  )})

currency_code <- memoise::memoise(
  ensure(post = list(result %is% vector, result %contains_only% simple_string),
  function() {
    unlist(lapply(currency_map(), `[[`, 1))
  }))
