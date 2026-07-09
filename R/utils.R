#' 
#' Collect all targets and lists of targets in the environment
#' 
#' 
all_targets <- function(env = parent.env(environment()), 
                        type = "tar_target", 
                        add_list_names = TRUE) {
  
  ## Function to determine if an object is a type (a target), 
  ## or a list on only that type
  rfn <- function(obj) 
    inherits(obj, type) || (is.list(obj) && all(vapply(obj, rfn, logical(1))))
  
  ## Get the names of everything in the environment 
  ## (e.g. sourced in the _targets.R file)
  objs <- ls(env)
  
  out <- list()
  for (o in objs) {
    obj <- get(o, envir = env)      ## Get each top-level object in turn
    if (rfn(obj)) {                 ## For targets and lists of targets
      out[[length(out) + 1]] <- obj ## Add them to the output
      
      ## If the object is a list of targets, add a vector of the target names 
      ## to the environment So that one can call `tar_make(list_name)` to make 
      ## all the targets in that list
      if (add_list_names && is.list(obj)) {
        target_names <- vapply(obj, \(x) x$settings$name, character(1))
        assign(o, target_names, envir = env)
      }
    }
  }
  return(out)
}


#'
#' Post-check cross-field constraints on a post-vaccination reaction record
#'
#' JSON Schema (see `schemas/post-vaccination-reaction.validate.json`) validates
#' types, enums and required fields but cannot express relationships *between*
#' fields. This helper enforces the cross-field rules the schema deliberately
#' omits:
#'   * `visit$vaccines_given_count` equals the number of vaccines listed
#'   * within a reaction, `symptom_end_datetime` is not before
#'     `symptom_start_datetime`
#'   * within a reaction, `treatment_end_date` is not before
#'     `treatment_start_date`
#'
#' Run this *after* structural JSON Schema validation, not instead of it.
#'
#' @param record A single record as a list (e.g. from
#'   `jsonlite::fromJSON(x, simplifyVector = FALSE)`), or a length-1 character
#'   vector giving a path to a `.json` file or a JSON string.
#'
#' @return Invisibly, a list with `valid` (logical) and `errors` (character
#'   vector, empty when valid). Reports rather than stops, so callers can
#'   collect issues across many generated records.
#'
validate_reaction_record <- function(record) {
  ## Accept a file path, a JSON string, or an already-parsed list ----
  if (is.character(record)) {
    record <- jsonlite::fromJSON(record, simplifyVector = FALSE)
  }

  errors <- character(0)
  add <- function(...) errors[[length(errors) + 1L]] <<- paste0(...)

  ## Lenient ISO-8601 parsers (offsets dropped; ordering only) ----
  parse_dt <- function(x) {
    x <- sub("Z$", "", x)                     # trailing UTC marker
    x <- sub("([+-]\\d{2}:?\\d{2})$", "", x)  # trailing numeric offset
    x <- sub("T", " ", x)
    as.POSIXct(x, format = "%Y-%m-%d %H:%M:%S", tz = "UTC")
  }
  parse_d <- function(x) as.Date(x, format = "%Y-%m-%d")

  ## Compare two optional temporal fields, requiring end >= start ----
  check_order <- function(start, end, parser, label, path) {
    if (is.null(start) || is.null(end)) return(invisible())
    s <- parser(start)
    e <- parser(end)
    if (is.na(s) || is.na(e)) {
      add(path, ": could not parse ", label, " (", start, " / ", end, ")")
    } else if (e < s) {
      add(path, ": ", label, " end (", end, ") is before start (", start, ")")
    }
  }

  ## visit: count must equal the number of vaccines listed ----
  count <- record$visit$vaccines_given_count
  n_vaccines <- length(record$visit$vaccines)
  if (!is.null(count) && count != n_vaccines) {
    add("visit: vaccines_given_count (", count,
        ") != number of vaccines listed (", n_vaccines, ")")
  }

  ## reactions: per-reaction temporal ordering ----
  for (i in seq_along(record$reactions)) {
    rx <- record$reactions[[i]]
    path <- paste0("reactions[", i, "]")

    check_order(
      rx$symptom_start_datetime, rx$symptom_end_datetime,
      parse_dt, "symptom datetime", path
    )
    check_order(
      rx$treatment_start_date, rx$treatment_end_date,
      parse_d, "treatment date", path
    )
  }

  invisible(list(valid = length(errors) == 0L, errors = errors))
}
