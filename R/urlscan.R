#' Perform a urlscan.io query
#'
#' urlscan.io uses an Elasticsearch back-end and enables querying by a number
#' of fields, including:
#' - `domain`: Domain (or a subdomain of it) is contacted in one of the requests
#' - `page.domain`: Domain (or a subdomain of it) is the first domain to be contacted
#' - `ip`: The IP or subnet are contacted in one request
#' - `asn`: The autonomous system (AS) was contacted (_must_ use `AS` prefix!) (comma-separated for more than one)
#' - `asname`: The autonomous system with this name was contacted (comma-separated for more than one)
#' - `filename`: This filename was requested
#' - `hash`: A resource with this SHA256 hash was downloaded
#' - `server`: The page contact a host running this web server
#' - `task.method`: one of "`manual`" or "`api`"; show manual (user) or API submissions
#'
#' The fields `ip`, `domain`, `url`, `asn`, `asnname`, `country` and `server` can also be prefixed with `page.`
#' to only match the value for the first request/response (e.g. `page.server:nginx AND page.domain:de`).
#' Furthermore, you can concatenate search-terms with `AND`, `OR`, etc.
#'
#' @md
#' @param query query to run
#' @param size number of results to return (default is `100`)
#' @param offset offset of first result (for pagination) (default is `0`)
#' @param sort sorting, specified via `$sort_field:$sort_order`. Default: `_score`
#' @references <https://urlscan.io/about-api/#search>
#' @note Search can only find **public** scans, there is no way to search for private scans.
#' @export
urlscan_search <- function(query, size=100, offset=0, sort=NULL) {

   httr::GET(
     url = "https://urlscan.io/api/v1/search/",
     query = list(
       q = query,
       size = size,
       offset = offset,
       sort = sort
     ),
     .URLSCANUA
   ) -> res

   httr::stop_for_status(res)

   res <- httr::content(res, as="text")

   res <- jsonlite::fromJSON(res)

   class(res) <- c("urlscan", "list")

   res

}