#' Print for urlscan_submit objects
#'
#' @param x urlscan_submit object
#' @param ... ignored
#' @keywords internal
#' @export
print.urlscan_submit <- function(x, ...) {

  cat(
    sprintf("  URL Submitted: %s", x$url),
    sprintf("  Submission ID: %s", x$uuid),
    sprintf("Submission Type: %s", x$visibility),
    sprintf("Submission Note: %s", x$message),
    sep = "\n"
  )

  invisible(x)

}

#' Print for urlscan objects
#'
#' @param x urlscan object
#' @param ... ignored
#' @keywords internal
#' @export
print.urlscan <- function(x, ...) {

  if (length(x$results) == 0) {
    cat("No search results\n")
  } else {
    cat(
      sprintf(
        "Total submissions for %s: %s.",
        x$results$page$domain[1],
        nrow(x$results$page)
      ),
      "Last submission results:",
      sprintf("Scan ID: %s", x$results$`_id`[1]),
      sprintf("     IP: %s", x$results$page$ip[1]),
      sprintf("     AS: %s / %s", x$results$page$asn[1], x$results$page$asnname[1]),
      sprintf("Country: %s", x$results$page$country[1]),
      sep = "\n"
    )
  }

  invisible(x)

}

#' Print for urlscan_result objects
#'
#' @param x urlscan_result object
#' @param ... ignored
#' @keywords internal
#' @export
print.urlscan_result <- function(x, ...) {

  if (length(x$scan_result) == 0) {
    cat("No result data\n")
  } else {
    cat(
      sprintf("            URL: %s", x$scan_result$page$url[1]),
      sprintf("        Scan ID: %s", x$scan_result$task$uuid[1]),
      sprintf("      Malicious: %s", x$scan_result$stats$malicious[1] == 1),
      sprintf("     Ad Blocked: %s", x$scan_result$stats$adBlocked[1] == 1),
      sprintf("    Total Links: %s", x$scan_result$stats$totalLinks),
      sprintf("Secure Requests: %s", x$scan_result$stats$secureRequests[1]),
      sprintf("   Secure Req %%: %s%%", x$scan_result$stats$securePercentage[1]),
      sep = "\n"
    )
  }

  invisible(x)

}
