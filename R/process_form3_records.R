#'
#' Process Form 3 record
#' 

process_form3_record <- function(record) {
  record <- record[[1]]

  record_df <- try(
    record |>
      tibble::as_tibble()
  )

  if (inherits(record_df, "try-error")) {
    warning("Failed to convert record to tibble: ", record)
    record_df <- NULL
  }

  record_df
}
