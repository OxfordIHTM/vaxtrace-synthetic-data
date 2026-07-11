#'
#' Unnest form 3 synthetic data
#' 

unnest_form3_synthetic_data <- function(.data) {
  .data |>
    tidyr::unnest_wider(col = c(vaccines, reactions)) |>
    tidyr::unnest_longer(col = antigens) |>
    tidyr::unnest_wider(
      col = c(managed_at_centre, managed_at_home), names_sep = "_"
    )
}
