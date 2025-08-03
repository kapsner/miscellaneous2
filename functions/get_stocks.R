get_stocks <- function(index, csv_path) {
  stopifnot(dir.exists(csv_path))

  if (index == "nasdaq") {
    url <- "https://stockanalysis.com/list/nasdaq-100-stocks"
  } else if (index == "dowjones") {
    url <- "https://stockanalysis.com/list/dow-jones-stocks"
  } else if (index == "snp500") {
    url <- "https://stockanalysis.com/list/sp-500-stocks"
  }
  url <- url |>
    URLencode()

  # https://stackoverflow.com/a/78338993
  UA <- httr::user_agent("Mozilla/5.0 Firefox")

  webpage <- httr::GET(url, UA) |>
    rvest::read_html() |>
    rvest::html_table()

  webpage <- data.table::as.data.table(webpage)

  webpage <- webpage[, .(Symbol)][order(Symbol)]
  colnames(webpage) <- "ric"

  if (index == "snp500") {
    webpage$ric <- gsub("BRK\\.B", "BRK-B", webpage$ric)
    webpage$ric <- gsub("BF\\.B", "BF-B", webpage$ric)
  }

  data.table::fwrite(
    x = webpage,
    file = file.path(csv_path, paste0("ric_", index, ".csv"))
  )
}

get_dax_stocks <- function(csv_path) {

  url <- "https://finance.yahoo.com/quote/^GDAXI/components/?guccounter=2" |>
    URLencode()

  # https://stackoverflow.com/a/78338993
  UA <- httr::user_agent("Mozilla/5.0 Firefox")


  webpage <- httr::GET(url, UA) |>
    rvest::read_html() |>
    rvest::html_table()

  webpage <- data.table::as.data.table(webpage)

  data.table::fwrite(
    x = webpage,
    file = file.path(csv_path, "ric_dax.csv")
  )
}
