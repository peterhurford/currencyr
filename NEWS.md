#### v0.0.0.9005

* Amends `exchange_rate` to get exchange rates up front.
* Amends convert to take an `as_of` parameter specifying a date to peg the conversion to.

#### v0.0.0.9004

* Fixes a terrible bug that made the exchange rate go in the wrong direction!
* Renames `fixer` function to be called the (more clear) `exchange_rate` function.

#### v0.0.0.9003

* Amends `currencyr::convert` to now round the result value to two decimal places.

#### v0.0.0.9002

* Amends API calls to be memoised since they only change daily.

#### v0.0.0.9001

* Renames `currencyr::currency` to `currencyr::convert`.
* Exports `currency_codes`.
* Fixes an improperly scoped function.

## v0.0.0.9000

* Initial package
