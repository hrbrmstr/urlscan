#' Submit a URL for scanning
#'
#' urlscan offers API access to submit URLs for researchers and other institutions.
#' Using the API requires an API key. If you'd like to start submitting URLs via the
#' API, contact them at <mailto:info@@urlscan.io> with a short description on how
#' you're planning to use the API. Submissions via the API can be public or private,
#' though they prefer public submissions so other users can benefit from the results
#' of your scans.\cr
#' \cr
#' The API key should be in the environment variable `URLSCAN_API_KEY` and the
#' easiest way to do that is via the `~/.Renviron` file. You can also manually pass
#' it in as a parameter.
#'
#' @md
#' @param url URL to submit
#' @param public Public or private results? `TRUE` (default) = public.
#' @param custom_agent (character) Override User-Agent for this scan
#' @param referer (character) Override HTTP referer for this scan
#' @param api_key your API key. See [urlscan_api_key()]
#' @return The response to the API call will give you the ID and API endpoint for t
#'         he scan, you can use it to retrieve the result after waiting for a short while.
#' @references <https://urlscan.io/about-api/#submission>
#' @export
urlscan_submit <- function(url, public=TRUE, custom_agent=NULL, referer=NULL,
                           api_key = urlscan_api_key()) {

   httr::POST(
     url = "https://urlscan.io/api/v1/scan/",
     encode = "json",
     httr::content_type_json(),
     body = list(
       url = url,
       public = if (public[1]) "on" else NULL,
       customagent = custom_agent,
       referer = referer
     ),
     httr::add_headers(
       `API-Key` = api_key
     ),
     .URLSCANUA
   ) -> res

   httr::stop_for_status(res)

   res <- httr::content(res, as="text")

   res <- jsonlite::fromJSON(res)

   class(res) <- c("urlscan_submit", "list")

   res

}