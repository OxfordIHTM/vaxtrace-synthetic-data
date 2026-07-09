# Targets for synthetic data generation for Form 4 -----------------------------

## LLM targets for Form 4 ----

llm_form4_targets <- tar_plan(
  ### LLM form 4 prompt files ----
  tar_target(
    name = prompt_form4_md,
    command = "prompts/form4_system_prompt.md",
    cue = tar_cue("always")
  ),

  ### LLM form 4 system prompt ----
  tar_target(
    name = prompt_form4_synthetic_data,
    command = ellmer::interpolate_file(path = prompt_form4_md),
    cue = tar_cue("always")
  ),

  ### LLM form 4 synthetic data generation output types ----
  tar_target(
    name = output_type_form4_synthetic_data,
    command = ellmer::type_from_schema(
      path = "schemas/anaphylaxis.generate.json"
    ),
    cue = tar_cue("always")
  )
)

## gemma form 4 synthetic data generation targets ----
gemma_form4_synthetic_data_targets <- tar_plan(
  ### Gemma synthetic data generator ----
  tar_target(
    name = gemma_form4_data_generator,
    command = ellmer::chat_ollama(
      model = gemma_model_name,
      system_prompt = prompt_form4_synthetic_data,
      echo = "none", 
    )
  ),

  ### Synthetic data generation ----
  tar_target(
    name = gemma_form4_synthetic_data,
    command = llm_generate_synthetic_data(
      generator = gemma_form4_data_generator,
      prompt = synthetic_data_generation_prompt_list,
      type = output_type_form4_synthetic_data
    ),
    pattern = map(synthetic_data_generation_prompt_list),
    iteration = "list"
  )
)


## gpt form 4 synthetic data generation targets ----
gpt_form4_synthetic_data_targets <- tar_plan(
  ### gpt synthetic data generator ----
  tar_target(
    name = gpt_form4_data_generator,
    command = ellmer::chat_ollama(
      model = gpt_model_name,
      system_prompt = prompt_form4_synthetic_data,
      echo = "none"
    )
  ),

  ### Synthetic data generation ----
  tar_target(
    name = gpt_form4_synthetic_data,
    command = llm_generate_synthetic_data(
      generator = gpt_form4_data_generator,
      prompt = synthetic_data_generation_prompt_list,
      type = output_type_form4_synthetic_data
    ),
    pattern = map(synthetic_data_generation_prompt_list),
    iteration = "list"
  )
)


## llama form4 synthetic data generation targets ----
llama_form4_synthetic_data_targets <- tar_plan(
  ### llama synthetic data generator ----
  tar_target(
    name = llama_form4_data_generator,
    command = ellmer::chat_ollama(
      model = llama_model_name,
      system_prompt = prompt_form4_synthetic_data,
      echo = "none"
    )
  ),

  ### Synthetic data generation ----
  tar_target(
    name = llama_form4_synthetic_data,
    command = llm_generate_synthetic_data(
      generator = llama_form4_data_generator,
      prompt = synthetic_data_generation_prompt_list,
      type = output_type_form4_synthetic_data
    ),
    pattern = map(synthetic_data_generation_prompt_list),
    iteration = "list"
  )
)


## qwen form4 synthetic data generation targets ----
qwen_form4_synthetic_data_targets <- tar_plan(
  ### qwen synthetic data generator ----
  tar_target(
    name = qwen_form4_data_generator,
    command = ellmer::chat_ollama(
      model = qwen_model_name,
      system_prompt = prompt_form4_synthetic_data,
      echo = "none"
    )
  ),

  ### Synthetic data generation ----
  tar_target(
    name = qwen_form4_synthetic_data,
    command = llm_generate_synthetic_data(
      generator = qwen_form4_data_generator,
      prompt = synthetic_data_generation_prompt_list,
      type = output_type_form4_synthetic_data
    ),
    pattern = map(synthetic_data_generation_prompt_list),
    iteration = "list"
  )
)
