# v0.0.0.9004

* Correct a terrible bug that made the exchange rate go in the wrong direction!
* Change `fixer` function to be called the (more clear) `exchange_rate` function.

# v0.0.0.9003

* `currencyr::convert` now rounds the result value to two decimal places.

# v0.0.0.9002

* Memoise the API calls since they only change daily.

# v0.0.0.9001

* Change from `currencyr::currency` to `currencyr::convert`.
* Export `currency_codes`.
* Bugfix an improperly scoped function.

# v0.0.0.9000

* Initial package
