
# urlscan

Analyze Websites and Resources They Request

## Description

WIP

The \<urlscan.io\> service provides an ‘API’ enabling analysis of
websites and the resources they request. Much like the ‘Inspector’ of
your browser, \<urlscan.io\> will let you take a look at the individual
resources that are requested when a site is loaded. Tools are provided
to search public \<urlscans.io\> scan submissions.

## What’s Inside The Tin

The following functions are implemented:

  - `urlscan_search`: Perform a urlscan.io query
  - `urlscan_result`:	Retrieve detailed results for a given scan ID

## Installation

``` r
devtools::install_github("hrbrmstr/urlscan")
```

## Usage

``` r
library(urlscan)

# current verison
packageVersion("urlscan")
```

    ## [1] '0.1.0'

``` r
library(tidyverse)
```

    ## ── Attaching packages ────────────────────────────────────── tidyverse 1.2.1 ──

    ## ✔ ggplot2 2.2.1.9000     ✔ purrr   0.2.4     
    ## ✔ tibble  1.4.2          ✔ dplyr   0.7.4     
    ## ✔ tidyr   0.7.2          ✔ stringr 1.2.0     
    ## ✔ readr   1.1.1          ✔ forcats 0.2.0

    ## ── Conflicts ───────────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()

``` r
x <- urlscan_search("domain:r-project.org")

bind_cols(
  select(x$results$task, -options) %>% 
    mutate(user_agent = x$results$task$options$useragent)
  ,x$results$stats, 
  x$results$page
) %>% 
  mutate(id = x$results$`_id`) %>% 
  mutate(result_api_url = x$results$result) %>% 
  tbl_df() -> xdf

xdf
```

    ## # A tibble: 12 x 22
    ##    visibility method  time  source url    user_agent   uniqIPs consoleMsgs dataLength encodedDataLeng… requests country
    ##    <chr>      <chr>   <chr> <chr>  <chr>  <chr>          <int>       <int>      <int>            <int>    <int> <chr>  
    ##  1 public     manual  2017… web    https… Mozilla/5.0…       1           0      12758              676        2 AT     
    ##  2 public     manual  2017… web    https… Mozilla/5.0…       1           0      14396              676        2 AT     
    ##  3 public     manual  2017… web    https… Mozilla/5.0…       2           0     286138            97317        6 AT     
    ##  4 public     manual  2017… web    https… <NA>               1           0          0                0        1 AT     
    ##  5 public     manual  2017… web    https… <NA>               1           0          0                0        1 AT     
    ##  6 public     manual  2017… web    https… <NA>               1           0       5284             1813        2 AT     
    ##  7 public     manual  2017… web    https… <NA>               1           0       5284             1813        2 AT     
    ##  8 public     manual  2017… web    https… <NA>               1           0       4297             1640        2 AT     
    ##  9 public     manual  2017… web    https… <NA>               1           0      14722             6288        9 AT     
    ## 10 public     manual  2017… web    https… <NA>               2           0     285893            97695        6 AT     
    ## 11 public     automa… 2017… hacke… https… <NA>               1           0     343270           101327        4 AT     
    ## 12 public     automa… 2017… hacke… https… <NA>               1           0     345452           101840        4 AT     
    ## # ... with 10 more variables: server <chr>, city <chr>, domain <chr>, ip <chr>, asnname <chr>, asn <chr>, url1 <chr>,
    ## #   ptr <chr>, id <chr>, result_api_url <chr>

``` r
glimpse(xdf)
```

    ## Observations: 12
    ## Variables: 22
    ## $ visibility        <chr> "public", "public", "public", "public", "public", "public", "public", "public", "public",...
    ## $ method            <chr> "manual", "manual", "manual", "manual", "manual", "manual", "manual", "manual", "manual",...
    ## $ time              <chr> "2017-12-29T17:23:39.785Z", "2017-12-20T15:52:22.902Z", "2017-11-10T13:40:19.991Z", "2017...
    ## $ source            <chr> "web", "web", "web", "web", "web", "web", "web", "web", "web", "web", "hackernews", "hack...
    ## $ url               <chr> "https://cran.r-project.org/web/packages/randomForest/index.html", "https://cran.r-projec...
    ## $ user_agent        <chr> "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) C...
    ## $ uniqIPs           <int> 1, 1, 2, 1, 1, 1, 1, 1, 1, 2, 1, 1
    ## $ consoleMsgs       <int> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    ## $ dataLength        <int> 12758, 14396, 286138, 0, 0, 5284, 5284, 4297, 14722, 285893, 343270, 345452
    ## $ encodedDataLength <int> 676, 676, 97317, 0, 0, 1813, 1813, 1640, 6288, 97695, 101327, 101840
    ## $ requests          <int> 2, 2, 6, 1, 1, 2, 2, 2, 9, 6, 4, 4
    ## $ country           <chr> "AT", "AT", "AT", "AT", "AT", "AT", "AT", "AT", "AT", "AT", "AT", "AT"
    ## $ server            <chr> "Apache/2.4.10 (Debian)", "Apache/2.4.10 (Debian)", "Apache/2.4.10 (Debian)", "Apache/2.4...
    ## $ city              <chr> "Vienna", "Vienna", "Vienna", "Vienna", "Vienna", "Vienna", "Vienna", "Vienna", "Vienna",...
    ## $ domain            <chr> "cran.r-project.org", "cran.r-project.org", "www.r-project.org", "cran.r-project.org", "c...
    ## $ ip                <chr> "137.208.57.37", "137.208.57.37", "137.208.57.37", "137.208.57.37", "137.208.57.37", "137...
    ## $ asnname           <chr> "Welthandelsplatz 1, AT", "Welthandelsplatz 1, AT", "Welthandelsplatz 1, AT", "Welthandel...
    ## $ asn               <chr> "AS1776", "AS1776", "AS1776", "AS1776", "AS1776", "AS1776", "AS1776", "AS1776", "AS1776",...
    ## $ url1              <chr> "https://cran.r-project.org/web/packages/randomForest/index.html", "https://cran.r-projec...
    ## $ ptr               <chr> "cran.wu-wien.ac.at", "cran.wu-wien.ac.at", "cran.wu-wien.ac.at", "cran.wu-wien.ac.at", "...
    ## $ id                <chr> "d134c3b7-f306-4c7b-b2cb-c0f900793083", "075778b6-20f6-45a9-bb76-a80ac9bae1d2", "fbacb280...
    ## $ result_api_url    <chr> "https://urlscan.io/api/v1/result/d134c3b7-f306-4c7b-b2cb-c0f900793083", "https://urlscan...

``` r
ures <- urlscan_result(xdf$id[2], TRUE, TRUE)

str(ures$scan_result, 2)
```

    ## List of 6
    ##  $ data :List of 6
    ##   ..$ requests:'data.frame': 2 obs. of  3 variables:
    ##   ..$ cookies : list()
    ##   ..$ console : list()
    ##   ..$ links   : list()
    ##   ..$ timing  :List of 6
    ##   ..$ globals :'data.frame': 2 obs. of  2 variables:
    ##  $ stats:List of 14
    ##   ..$ resourceStats   :'data.frame': 2 obs. of  9 variables:
    ##   ..$ protocolStats   :'data.frame': 1 obs. of  7 variables:
    ##   ..$ tlsStats        :'data.frame': 1 obs. of  7 variables:
    ##   ..$ serverStats     :'data.frame': 1 obs. of  6 variables:
    ##   ..$ domainStats     :'data.frame': 1 obs. of  9 variables:
    ##   ..$ regDomainStats  :'data.frame': 1 obs. of  9 variables:
    ##   ..$ secureRequests  : int 2
    ##   ..$ securePercentage: int 100
    ##   ..$ IPv6Percentage  : int 0
    ##   ..$ uniqCountries   : int 1
    ##   ..$ totalLinks      : int 0
    ##   ..$ malicious       : int 0
    ##   ..$ adBlocked       : int 0
    ##   ..$ ipStats         :'data.frame': 1 obs. of  14 variables:
    ##  $ meta :List of 1
    ##   ..$ processors:List of 8
    ##  $ task :List of 11
    ##   ..$ uuid         : chr "075778b6-20f6-45a9-bb76-a80ac9bae1d2"
    ##   ..$ time         : chr "2017-12-20T15:52:22.902Z"
    ##   ..$ url          : chr "https://cran.r-project.org/web/packages/e1071/"
    ##   ..$ visibility   : chr "public"
    ##   ..$ options      :List of 1
    ##   ..$ method       : chr "manual"
    ##   ..$ source       : chr "web"
    ##   ..$ userAgent    : chr "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36"
    ##   ..$ reportURL    : chr "https://urlscan.io/result/075778b6-20f6-45a9-bb76-a80ac9bae1d2/"
    ##   ..$ screenshotURL: chr "https://urlscan.io/screenshots/075778b6-20f6-45a9-bb76-a80ac9bae1d2.png"
    ##   ..$ domURL       : chr "https://urlscan.io/dom/075778b6-20f6-45a9-bb76-a80ac9bae1d2/"
    ##  $ page :List of 9
    ##   ..$ url    : chr "https://cran.r-project.org/web/packages/e1071/"
    ##   ..$ domain : chr "cran.r-project.org"
    ##   ..$ country: chr "AT"
    ##   ..$ city   : chr "Vienna"
    ##   ..$ server : chr "Apache/2.4.10 (Debian)"
    ##   ..$ ip     : chr "137.208.57.37"
    ##   ..$ ptr    : chr "cran.wu-wien.ac.at"
    ##   ..$ asn    : chr "AS1776"
    ##   ..$ asnname: chr "Welthandelsplatz 1, AT"
    ##  $ lists:List of 9
    ##   ..$ ips         : chr "137.208.57.37"
    ##   ..$ countries   : chr "AT"
    ##   ..$ asns        : chr "1776"
    ##   ..$ domains     : chr "cran.r-project.org"
    ##   ..$ servers     : chr "Apache/2.4.10 (Debian)"
    ##   ..$ urls        : chr [1:2] "https://cran.r-project.org/web/packages/e1071/" "https://cran.r-project.org/web/CRAN_web.css"
    ##   ..$ linkDomains : list()
    ##   ..$ certificates:'data.frame': 1 obs. of  5 variables:
    ##   ..$ hashes      : chr [1:2] "48f7615c35fe15989530b1df31256a02340bed62069275c534a4222791eb23b2" "6a738f3da9f1203b5d765088a4ff4e4ac36c59fad008f450b808354d9625bc51"
    ##  - attr(*, "class")= chr [1:2] "urlscan_result" "list"

``` r
magick::image_write(ures$screenshot, "img/shot.png")
```

![](img/shot.png)
