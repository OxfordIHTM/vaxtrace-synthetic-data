# Generate synthetic data of adverse effects from immunisation (AEFI) ----------


## Load libraries and custom functions ----
suppressPackageStartupMessages(source("packages.R"))
for (f in list.files(here::here("R"), full.names = TRUE)) source (f)


## Data targets ----
data_targets <- tar_plan(
  
)


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

  ### LLM prompt files ----
  tar_target(
    name = prompt_form1_md,
    command = "prompts/form1_system_prompt.md",
    cue = tar_cue("always")
  ),

  ### LLM prompt targets ----
  tar_target(
    name = synthetic_data_form1_prompt,
    command = ellmer::interpolate_file(path = prompt_form1_md, n_rows = 1000L),
    cue = tar_cue("always")
  ),

  ### LLM synthetic data generation output types ----
  tar_target(
    name = synthetic_data_output_type,
    command = llm_create_form1_type()
  ),

  ### Number of synthetic data rows to generate ----
  synthetic_data_rows = 200L,

  ### Create a list of prompts to trigger dynamic branching ----
  tar_target(
    name = synthetic_data_generation_prompt_list,
    command = rep(
      "Generate synthetic data based on the provided system prompt.",
      times = synthetic_data_rows
    )
  )
)


## Gemini synthetic data generation targets ----
gemini_synthetic_data_targets <- tar_plan(
  ### Model name for Gemini LLM ----
  gemini_model_name = "gemini-pro-latest",

  ### Gemini synthetic data generator ----
  tar_target(
    name = gemini_data_generator,
    command = ellmer::chat_google_gemini(
      model = gemini_model_name,
      system_prompt = synthetic_data_form1_prompt,
      params = llm_parameters,
      echo = "none"
    )
  ),

  ### Synthetic data generation ----
  tar_target(
    name = gemini_synthetic_data_form1,
    command = llm_generate_synthetic_data(
      generator = gemini_data_generator,
      prompt = synthetic_data_generation_prompt_list,
      type = synthetic_data_output_type,
      model = gemini_model_name
    ),
    pattern = map(synthetic_data_generation_prompt_list)
  )
)


## gemma synthetic data generation targets ----
gemma_synthetic_data_targets <- tar_plan(
  ### Model name for Gemma LLM ----
  targets::tar_target(
    name = gemma_model_name,
    command = get_llm_name("gemma3")
  ),

  ### Gemma synthetic data generator ----
  tar_target(
    name = gemma_data_generator,
    command = ellmer::chat_ollama(
      model = gemma_model_name,
      echo = "none"
    )
  ),

  ### Synthetic data generation ----
  tar_target(
    name = gemma_synthetic_data_form1,
    command = llm_generate_synthetic_data(
      generator = gemma_data_generator,
      prompt = synthetic_data_generation_prompt_list,
      type = synthetic_data_output_type,
      model = gemma_model_name
    ),
    pattern = map(synthetic_data_generation_prompt_list)
  )
)


## gpt synthetic data generation targets ----
gpt_synthetic_data_targets <- tar_plan(
  ### Model name for Gemma LLM ----
  targets::tar_target(
    name = gpt_model_name,
    command = get_llm_name("gpt")
  ),

  ### gpt synthetic data generator ----
  tar_target(
    name = gpt_data_generator,
    command = ellmer::chat_ollama(
      model = gpt_model_name,
      echo = "none"
    )
  ),

  ### Synthetic data generation ----
  tar_target(
    name = gpt_synthetic_data_form1,
    command = llm_generate_synthetic_data(
      generator = gpt_data_generator,
      prompt = synthetic_data_generation_prompt_list,
      type = synthetic_data_output_type,
      model = gpt_model_name
    ),
    pattern = map(synthetic_data_generation_prompt_list)
  )
)


## llama synthetic data generation targets ----
llama_synthetic_data_targets <- tar_plan(
  ### Model name for llama LLM ----
  targets::tar_target(
    name = llama_model_name,
    command = get_llm_name("llama4")
  ),

  ### llama synthetic data generator ----
  tar_target(
    name = llama_data_generator,
    command = ellmer::chat_ollama(
      model = llama_model_name,
      echo = "none"
    )
  ),

  ### Synthetic data generation ----
  tar_target(
    name = llama_synthetic_data_form1,
    command = llm_generate_synthetic_data(
      generator = llama_data_generator,
      prompt = synthetic_data_generation_prompt_list,
      type = synthetic_data_output_type,
      model = llama_model_name
    ),
    pattern = map(synthetic_data_generation_prompt_list)
  )
)


## Processing targets ----
processing_targets <- tar_plan(
  
)


## Analysis targets ----
analysis_targets <- tar_plan(
  
)


## Output targets ----
output_targets <- tar_plan(
  tar_target(
    name = gemini_form1_csv_path,
    command = output_to_csv(
      data = gemini_synthetic_data_form1,
      path = "data/gemini_synthetic_data_form1.csv",
      overwrite = TRUE
    ),
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
