httr::user_agent(
  sprintf(
    "urlscanR package v%s: (<%s>)",
    utils::packageVersion("urlscan"),
    utils::packageDescription("urlscan")$URL
  )
) -> .URLSCANUA
