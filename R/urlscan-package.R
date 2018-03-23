#' Analyze Websites and Resources They Request
#'
#' The <urlscan.io> service provides an 'API' enabling analysis of
#' websites and the resources they request. Much like the 'Inspector' of your
#' browser, <urlscan.io> will let you take a look at the individual resources
#' that are requested when a site is loaded. Tools are provided to search
#' public <urlscans.io> scan submissions.
#'
#' @md
#' @name urlscan
#' @docType package
#' @author Bob Rudis (bob@@rud.is)
#' @importFrom httr GET user_agent content stop_for_status warn_for_status status_code
#' @importFrom jsonlite fromJSON
#' @importFrom magick image_read
NULL
