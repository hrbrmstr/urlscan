context("urlscan api interaction works")
test_that("we can do something", {

  skip_if(
    inherits(
      try(pingr::ping_port("google.com"), silent = TRUE),
      "try-error"
    ),
    message = "Skipping due to internet connection not detected"
  )

  x <- urlscan_search("r-project")

  expect_is(x, "urlscan")
  expect_true(length(x$results$stats) > 0)

  r <- urlscan_result(x$results[["_id"]][1])
  expect_is(r, "urlscan_result")
  expect_true(length(r$scan_result$task) > 0)

})
