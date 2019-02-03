#' Get or set URLSCAN_API_KEY value
#'
#' The API wrapper functions in this package all rely on a urlscan API
#' key residing in the environment variable `URLSCAN_API_KEY`. The
#' easiest way to accomplish this is to set it in the `.Renviron` file in your
#' home directory.
#'
#' @md
#' @param force Force setting a new urlscan API key for the current environment?
#' @return atomic character vector containing the urlscan API key
#' @references <https://urlscan.io/about-api/>
#' @export
urlscan_api_key <- function(force = FALSE) {
  env <- Sys.getenv("URLSCAN_API_KEY")
  if (!identical(env, "") && !force) return(env)

  if (!interactive()) {
    stop(
      "Please set env var URLSCAN_API_KEY to your urlscan API key",
      call. = FALSE
    )
  }

  message("Couldn't find env var URLSCAN_API_KEY See ?urlscan_api_key for more details.")
  message("Please enter your urlscan API key and press enter:")
  pat <- readline(": ")

  if (identical(pat, "")) {
    stop("urlscan API key entry failed", call. = FALSE)
  }

  message("Updating URLSCAN_API_KEY env var to PAT")
  Sys.setenv(urlscan_API_KEY = pat)

  pat
}
