#'
#' Generate synthetic data based on specified JSON schema
#' 
#' 

llm_generate_synthetic_data <- function(generator, prompt, type, max_tries = 3L,
                                        keep_turns = TRUE) {
  for (attempt in seq_len(max_tries)) {
    if (!keep_turns) generator <- generator$set_turns(list())
    
    out <- tryCatch(
      generator$chat_structured(
        prompt,
        type = type
      ),
      error = function(e) {
        if (attempt == max_tries) {
          cli::cli_abort(
            "Structured synthetic data generation failed after {max_tries} attempt/s.",
            parent = e
          )
        }
        cli::cli_warn(
          "Synthetic data generation attempt {attempt}/{max_tries} failed ({conditionMessage(e)}); retrying."
        )
        NULL
      }
    )
  }

  out
}