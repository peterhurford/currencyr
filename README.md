## CurrencyR <a href="https://travis-ci.org/peterhurford/currencyr"><img src="https://img.shields.io/travis/peterhurford/currencyr.svg"></a> <a href="https://codecov.io/github/peterhurford/currencyr"><img src="https://img.shields.io/codecov/c/github/peterhurford/currencyr.svg"></a> <a href="https://github.com/peterhurford/currencyr/tags"><img src="https://img.shields.io/github/tag/peterhurford/currencyr.svg"></a>

**CurrencyR** is a package for converting currencies into other currencies. It is backed by the [Fixer.io API](http://fixer.io/), a free JSON API for current and historical foreign exchange rates published by the European Central Bank.

```R
currency <- currencyr::convert(1000, from = "USD", to = "CAD")
currency
# 1302.8 Canadian Dollar
currency$value
# 1302.8
currency$exchange_rate
# 1.3028
currency$unit
# "Canadian Dollar"
currency$code
# "CAD"
```

## Installation

This package is not yet available from CRAN. To install the latest development builds directly from GitHub, run this instead:

```R
if (!require("devtools")) install.packages("devtools")
devtools::install_github("peterhurford/currencyr")
```
