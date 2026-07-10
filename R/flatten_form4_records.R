#'
#' Flatten form 4 record
#' 

flatten_form4_record <- function(record) {
  record <- record[[1]]

  ## allergy_history ----
  allergy_history <- record$allergy_history |>
    dplyr::bind_rows()

  ## vaccines ----
  vaccines <- record$vaccines |>
    dplyr::bind_rows()

  ## manifestations ----
  manifestations <- record$manifestations |>
    dplyr::bind_rows()

  ## self_care ----
  self_care <- record$self_care |>
    dplyr::bind_rows()

  ## resolution ----
  resolution <- record$resolution |>
    dplyr::bind_rows()

  ## centre_care ----
  centre_care <- record$centre_care |>
    dplyr::bind_rows()

  tibble::tibble(
    tibble::as_tibble(record[1:7]),
    allergy_history = list(allergy_history),
    vaccines_given_count = record$vaccines_given_count,
    vaccines = list(vaccines),
    tibble::as_tibble(record[11:12]),
    manifestations = list(manifestations),
    clinical_description = record$clinical_description,
    self_care = list(self_care),
    resolution = list(resolution),
    outcome = record$outcome,
    centre_care = list(centre_care)
  )
}
