currency <- checkr::ensure(
  pre = list(
    amount %is% numeric, length(amount) == 1,
    from %in% currency_codes(),
    to %in% currency_codes()),
  post = list(
    result %is% currency
  ),
  function(amount, from = "USD", to = "USD") {
    "TODO"
  })
