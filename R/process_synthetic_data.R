#'
#' Process synthetic data
#' 

process_synthetic_data <- function(.data) {
  if (!is.data.frame(.data)) {
    .data <- .data[[1]]
  }

  n_rows <- nrow(.data)

  .data <- .data |>
    dplyr::mutate(number = seq_len(n_rows), .before = 1)

  if ("customer_id" %in% names(.data)) {
    .data <- .data |>
      dplyr::mutate(
        customer_id = generate_random_id(size = n_rows)
      )
  }

  if ("client_id" %in% names(.data)) {
    .data <- .data |>
      dplyr::mutate(
        client_id = generate_random_id(size = n_rows)
      )
  }

  .data
}
