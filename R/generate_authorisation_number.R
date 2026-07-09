#' 
#' Generate strings of the form [A-Z]{3}-\d{6} over a bounded range
#'
#' @param letters_from,letters_to 3-letter bounds, inclusive (e.g. "AAA", "ABZ").
#' @param digits_from,digits_to Integer bounds for the 6-digit part, inclusive
#'   (0 to 999999).
#' @param as_vector If TRUE (default) returns the full character vector; if FALSE
#'   returns a function that yields the string at a given index.
#'
#' @returns A character vector, or an indexer function (see `as_vector`).
#' 
#' 
#' 

generate_authorisation_numbers <- function(letters_from = "AAA", 
                                           letters_to = "ZZZ",
                                           digits_from = 0L,
                                           digits_to = 999999L,
                                           as_vector = TRUE) {
  ## Check inputs and compute ranges ----
  lo_from <- convert_letters_to_ord(letters_from)
  lo_to   <- convert_letters_to_ord(letters_to)
  
  stopifnot(
    lo_from <= lo_to, 
    digits_from >= 0, 
    digits_to <= 999999,
    digits_from <= digits_to
  )

  letter_ords <- seq.int(lo_from, lo_to)        # letter combos in range
  digit_vals  <- seq.int(digits_from, digits_to)
  n_letters   <- length(letter_ords)
  n_digits    <- length(digit_vals)
  total       <- n_letters * n_digits

  ## lazy indexer: index (1-based) -> string ----
  id_at <- function(i) {
    i    <- i - 1
    lord <- letter_ords[i %/% n_digits + 1]     # which letter combo
    dval <- digit_vals[i %%  n_digits + 1]     # which digit value
    sprintf("%s-%06d", convert_ord_to_letters(lord), dval)
  }

  if (!as_vector) {
    attr(id_at, "length") <- total              # so callers know the size
    return(id_at)
  }

  id_at(seq_len(total))                         # materialise the whole range
}


#'
#' Map 3 letters to a 0-based ordinal (0 to 17575) and vice versa.
#' 
#' The mapping is lexicographic, so "AAA" -> 0, "AAB" -> 1, ..., "ZZZ" -> 17575.
#' 
#' @param s A string of 3 uppercase letters (A-Z).
#' @param o An integer in the range 0 to 17575.
#' 
#' @returns For `letters_to_ord`, an integer in the range 0 to 17575.
#'   For `ord_to_letters`, a string of 3 uppercase letters.
#' 
#' @rdname convert_
#' 

convert_letters_to_ord <- function(s) {
  stopifnot(grepl("^[A-Z]{3}$", s))
  d <- utf8ToInt(s) - utf8ToInt("A")  # 3 digits base 26
  d[1] * 676L + d[2] * 26L + d[3]
}

#'
#' @rdname convert_
#'

convert_ord_to_letters <- function(o) {
  l1 <-  o %/% 676
  l2 <- (o %/% 26) %% 26
  l3 <-  o %% 26
  paste0(LETTERS[l1 + 1], LETTERS[l2 + 1], LETTERS[l3 + 1])
}

