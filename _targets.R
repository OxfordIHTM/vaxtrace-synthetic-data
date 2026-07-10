# Generate synthetic data of adverse effects from immunisation (AEFI) ----------


## Load libraries and custom functions ----
suppressPackageStartupMessages(source("packages.R"))
for (f in list.files(here::here("R"), full.names = TRUE)) source (f)


## LLM targets ----
llm_targets <- tar_plan(
  ### LLM parameters ----
  tar_target(
    name = llm_parameters,
    command = ellmer::params(
      temperature = 1.0,
      top_p = 0.95,
      top_k = 64
    )
  ),

  ### LLM user prompt ----
  tar_target(
    name = synthetic_data_user_prompt,
    command = readLines("prompts/user_prompt.md"),
    cue = tar_cue("always")
  ),

  ### Number of synthetic data rows to generate ----
  tar_target(
    name = synthetic_data_rows,
    command = 50L,
    cue = tar_cue("always")
  ),

  ### Create a list of prompts to trigger dynamic branching ----
  tar_target(
    name = synthetic_data_generation_prompt_list,
    command = rep(
      synthetic_data_user_prompt,
      times = synthetic_data_rows
    ),
    cue = tar_cue("always")
  ),

  ### Model name for Gemma LLM ----
  targets::tar_target(
    name = gemma_model_name,
    command = get_llm_name("gemma3")
  ),

  ### Model name for gpt LLM ----
  targets::tar_target(
    name = gpt_model_name,
    command = get_llm_name("gpt")
  ),  

  ### Model name for llama LLM ----
  targets::tar_target(
    name = llama_model_name,
    command = get_llm_name("llama4")
  ),

  ### Model name for qwen LLM ----
  targets::tar_target(
    name = qwen_model_name,
    command = get_llm_name("qwen3.5")
  )
)


## Form 1 synthetic data generation targets ----
source("_targets_form1.R")


## Form 2 synthetic data generation targets ----
source("_targets_form2.R")


## Form 3 synthetic data generation targets ----
source("_targets_form3.R")


## Form 4 synthetic data generation targets ----
source("_targets_form4.R")


## Processing targets ----
processing_targets <- tar_plan(
  ### Concatenate form1 synthetic data ----
  tar_target(
    name = synthetic_data_raw_form1,
    command = rbind(
      gemma = gemma_form1_synthetic_data,
      gpt = gpt_form1_synthetic_data,
      llama = llama_form1_synthetic_data,
      qwen = qwen_form1_synthetic_data
    )
  ),

  ### Process form1 synthetic data ----
  tar_target(
    name = synthetic_data_processed_form1,
    command = process_synthetic_data(synthetic_data_raw_form1)
  ),

  ### Concatenate form2 synthetic data ----
  tar_target(
    name = synthetic_data_raw_form2,
    command = rbind(
      gemma = gemma_form2_synthetic_data,
      gpt = gpt_form2_synthetic_data,
      llama = llama_form2_synthetic_data,
      qwen = qwen_form2_synthetic_data
    )
  ),

  ### Process form2 synthetic data ----
  tar_target(
    name = synthetic_data_processed_form2,
    command = process_synthetic_data(synthetic_data_raw_form2)
  ),

  ### Concatenate form3 synthetic data ----
  tar_target(
    name = synthetic_data_raw_form3,
    command = c(
      gemma = gemma_form3_synthetic_data,
      gpt = gpt_form3_synthetic_data,
      llama = llama_form3_synthetic_data,
      qwen = qwen_form3_synthetic_data
    )
  ),

  ### Flatten form3 synthetic data raw ----
  tar_target(
    name = synthetic_data_raw_flattened_form3,
    command = process_form3_record(synthetic_data_raw_form3),
    pattern = map(synthetic_data_raw_form3)
  ),

  ### Process form3 synthetic data ----
  tar_target(
    name = synthetic_data_processed_form3,
    command = process_synthetic_data(synthetic_data_raw_flattened_form3)
  ),

  ### Concatenate form4 synthetic data ----
  tar_target(
    name = synthetic_data_raw_form4,
    command = c(
      gemma = gemma_form4_synthetic_data,
      gpt = gpt_form4_synthetic_data,
      llama = llama_form4_synthetic_data,
      qwen = qwen_form4_synthetic_data
    )
  ),

  ### Flatten form4 synthetic data raw ----
  tar_target(
    name = synthetic_data_raw_flattened_form4,
    command = flatten_form4_record(synthetic_data_raw_form4),
    pattern = map(synthetic_data_raw_form4)
  ),

  ### Process form4 synthetic data ----
  tar_target(
    name = synthetic_data_processed_form4,
    command = process_synthetic_data(
      synthetic_data_raw_flattened_form4, form = "form4"
    )
  )
)


## Analysis targets ----
analysis_targets <- tar_plan(
  
)


## Output targets ----
output_targets <- tar_plan(
  tar_target(
    name = synthetic_data_processed_form1_csv,
    command = output_to_csv(
      data = synthetic_data_processed_form1,
      path = "data/synthetic_data_form1.csv",
      overwrite = TRUE
    )
  ),
  tar_target(
    name = synthetic_data_processed_form2_csv,
    command = output_to_csv(
      data = synthetic_data_processed_form2,
      path = "data/synthetic_data_form2.csv",
      overwrite = TRUE
    )
  ),
  tar_target(
    name = synthetic_data_processed_form4_csv,
    command = output_to_csv(
      data = synthetic_data_processed_form4,
      path = "data/synthetic_data_form4.csv",
      overwrite = TRUE
    )
  )
)


## Reporting targets ----
report_targets <- tar_plan(
  
)


## Deploy targets ----
deploy_targets <- tar_plan(
  
)


## List targets ----
all_targets()
