#' #' Turn urlscan object into a data frame
#' #'
#' #' param x `urlscan` object
#' #' param ... unused
#' #' export
#' as.data.frame.urlscan <- function(x, ...) {
#'
#'   res <- x$results
#'   class(res) <- c("tbl_df", "tbl", "data.frame")
#'   res
#'
#' }