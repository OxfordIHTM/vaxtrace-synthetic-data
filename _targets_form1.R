# Targets for synthetic data generation for Form 1 -----------------------------

## LLM targets for Form 1 ----

llm_form1_targets <- tar_plan(
  ### LLM form 1 prompt files ----
  tar_target(
    name = prompt_form1_md,
    command = "prompts/form1_system_prompt.md",
    cue = tar_cue("always")
  ),

  ### LLM form 1 system prompt ----
  tar_target(
    name = prompt_form1_synthetic_data,
    command = ellmer::interpolate_file(path = prompt_form1_md),
    cue = tar_cue("always")
  ),

  ### LLM form 1 synthetic data generation output types ----
  tar_target(
    name = output_type_form1_synthetic_data,
    command = llm_create_form1_type()
  )
)

## gemma form 1 synthetic data generation targets ----
gemma_form1_synthetic_data_targets <- tar_plan(
  ### Gemma synthetic data generator ----
  tar_target(
    name = gemma_form1_data_generator,
    command = ellmer::chat_ollama(
      model = gemma_model_name,
      system_prompt = prompt_form1_synthetic_data,
      echo = "none"
    )
  ),

  ### Synthetic data generation ----
  tar_target(
    name = gemma_form1_synthetic_data,
    command = llm_generate_synthetic_data(
      generator = gemma_form1_data_generator,
      prompt = synthetic_data_generation_prompt_list,
      type = output_type_form1_synthetic_data
    ),
    pattern = map(synthetic_data_generation_prompt_list)
  )
)


## gpt form 1 synthetic data generation targets ----
gpt_form1_synthetic_data_targets <- tar_plan(
  ### gpt synthetic data generator ----
  tar_target(
    name = gpt_form1_data_generator,
    command = ellmer::chat_ollama(
      model = gpt_model_name,
      system_prompt = prompt_form1_synthetic_data,
      echo = "none"
    )
  ),

  ### Synthetic data generation ----
  tar_target(
    name = gpt_form1_synthetic_data,
    command = llm_generate_synthetic_data(
      generator = gpt_form1_data_generator,
      prompt = synthetic_data_generation_prompt_list,
      type = output_type_form1_synthetic_data
    ),
    pattern = map(synthetic_data_generation_prompt_list)
  )
)


## llama form1 synthetic data generation targets ----
llama_form1_synthetic_data_targets <- tar_plan(
  ### llama synthetic data generator ----
  tar_target(
    name = llama_form1_data_generator,
    command = ellmer::chat_ollama(
      model = llama_model_name,
      system_prompt = prompt_form1_synthetic_data,
      echo = "none"
    )
  ),

  ### Synthetic data generation ----
  tar_target(
    name = llama_form1_synthetic_data,
    command = llm_generate_synthetic_data(
      generator = llama_form1_data_generator,
      prompt = synthetic_data_generation_prompt_list,
      type = output_type_form1_synthetic_data
    ),
    pattern = map(synthetic_data_generation_prompt_list)
  )
)


## qwen form1 synthetic data generation targets ----
qwen_form1_synthetic_data_targets <- tar_plan(
  ### qwen synthetic data generator ----
  tar_target(
    name = qwen_form1_data_generator,
    command = ellmer::chat_ollama(
      model = qwen_model_name,
      system_prompt = prompt_form1_synthetic_data,
      echo = "none"
    )
  ),

  ### Synthetic data generation ----
  tar_target(
    name = qwen_form1_synthetic_data,
    command = llm_generate_synthetic_data(
      generator = qwen_form1_data_generator,
      prompt = synthetic_data_generation_prompt_list,
      type = output_type_form1_synthetic_data
    ),
    pattern = map(synthetic_data_generation_prompt_list)
  )
)
