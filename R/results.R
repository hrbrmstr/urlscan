#' Retrieve detailed results for a given scan ID
#'
#' @md
#' @param scan_id scan id (UUID)
#' @param include_dom (logical) include the website DOM? (default: `FALSE`)
#' @param include_shot (logical) include the website screen shot? (default: `FALSE`)
#' @return `list` with `scan_result` task, page, content lists, fetch data,
#'         connection metadata and computed stats.\cr
#'         \cr
#'         The list can also include `dom` if
#'         `include_dom` is `TRUE`. If so, `dom` will be an `httr` `response` object
#'         since the data could be binary. Use `httr` tools to process it.\cr
#'         \cr
#'         The list can also include `screenshot` if `include_shot` is `TRUE` and
#'         a screenshot was available.
#' @export
#' @examples
#' x <- urlscan_search("domain:r-project.org")
#' r <- urlscan_result(x$results[["_id"]][1])
urlscan_result <- function(scan_id, include_dom=FALSE, include_shot=FALSE) {

  httr::GET(
    url = sprintf("https://urlscan.io/api/v1/result/%s", scan_id),
    .URLSCANUA
  ) -> res

  httr::stop_for_status(res)

  res <- httr::content(res, as="text")

  res <- jsonlite::fromJSON(res)

  out <- list(scan_result = res)

  if (include_dom) {

    httr::GET(
      url = sprintf("https://urlscan.io/dom/%s", scan_id),
      .URLSCANUA
    ) -> res

    out$dom <- res

  }

  if (include_shot) {

    httr::GET(
      url = sprintf("https://urlscan.io/screenshots/%s.png", scan_id),
      .URLSCANUA
    ) -> res

    if (httr::status_code(res) == 200) out$screenshot <-  magick::image_read(res$content)

  }

  class(out) <- c("urlscan_result", "list")

  out

}