#'
#' Unnest form 4 synthetic data
#' 

unnest_form4_synthetic_data <- function(.data) {
  .data |>
    tidyr::unnest_longer(col = allergy_history) |>
    tidyr::unnest_longer(col = vaccines) |>
    tidyr::unnest_longer(col = manifestations) |>
    tidyr::unnest_longer(col = self_care) |>
    tidyr::unnest_longer(col = resolution) |>
    tidyr::unnest_longer(col = centre_care)
}
