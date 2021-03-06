% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/convert.R
\name{convert}
\alias{convert}
\title{Convert a currency into another currency.}
\usage{
convert(amount, from = "USD", to = "USD", as_of = NULL)
}
\arguments{
\item{amount}{numeric. The amount to convert.}

\item{from}{character. The currency code to convert from. Defaults to \code{USD}.}

\item{to}{character. The currency code to convert to. Defaults to \code{USD}.}

\item{as_of}{character. The time of conversion to use for calculating the exchange rate.
\code{latest} or \code{today} or \code{NULL} uses the most recent rate (default). Otherwise,
one can enter in a string in "yyyy-mm-dd" format (e.g., "2004-01-30") to get the historical
exchange rate as of that time. Only dates on or after 2000-01-01 are supported.}
}
\value{
the amount in the converted currency.
}
\description{
Convert a currency into another currency.
}
