% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/api-key.R
\name{urlscan_api_key}
\alias{urlscan_api_key}
\title{Get or set URLSCAN_API_KEY value}
\usage{
urlscan_api_key(force = FALSE)
}
\arguments{
\item{force}{Force setting a new urlscan API key for the current environment?}
}
\value{
atomic character vector containing the urlscan API key
}
\description{
The API wrapper functions in this package all rely on a urlscan API
key residing in the environment variable \code{URLSCAN_API_KEY}. The
easiest way to accomplish this is to set it in the \code{.Renviron} file in your
home directory.
}
\references{
\url{https://urlscan.io/about-api/}
}
