#'
#' Generate random customer or client identifier
#'

generate_random_id <- function(size) {
  sample(x = 999999, size = size, replace = FALSE) |>
    stringr::str_pad(width = 10, side = "left", pad = "0")
}
