#'
#' 
#' 

generate_lot_numbers <- function(digits_from = 0L, digits_to = 999L) {
  ## Check inputs and compute ranges ----
  stopifnot(
    digits_from >= 0, 
    digits_to <= 999,
    digits_from <= digits_to
  )

  left_digit_vals   <- seq.int(digits_from, digits_to)
  middle_digit_vals <- seq.int(0L, 99L)
  right_digit_vals  <- seq.int(0L, 99L)

  n_digits   <- length(digit_vals)
  total      <- n_digits * n_digits * n_digits

  ## lazy indexer: index (1-based) -> string ----
  id_at <- function(i) {
    i     <- i - 1
    dval1 <- digit_vals[i %/% (n_digits * n_digits) %% n_digits + 1]
    dval2 <- digit_vals[i %/% n_digits %% n_digits + 1]
    dval3 <- digit_vals[i %% n_digits + 1]
    sprintf("%03d-%02d-%02d", dval1, dval2, dval3)
  }

  if (!as_vector) {
    attr(id_at, "length") <- total              # so callers know the size
    return(id_at)
  }

  id_at(seq_len(total))                         # materialise the whole range
}