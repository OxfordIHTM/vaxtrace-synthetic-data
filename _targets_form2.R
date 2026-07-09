# Targets for synthetic data generation for Form 2 -----------------------------

## LLM targets for Form 2 ----

llm_form2_targets <- tar_plan(
  ### LLM form 2 prompt files ----
  tar_target(
    name = prompt_form2_md,
    command = "prompts/form2_system_prompt.md",
    cue = tar_cue("always")
  ),

  ### LLM form 2 system prompt ----
  tar_target(
    name = prompt_form2_synthetic_data,
    command = ellmer::interpolate_file(path = prompt_form2_md),
    cue = tar_cue("always")
  ),

  ### LLM form 2 synthetic data generation output types ----
  tar_target(
    name = output_type_form2_synthetic_data,
    command = llm_create_form2_type()
  )
)

## gemma form 2 synthetic data generation targets ----
gemma_form2_synthetic_data_targets <- tar_plan(
  ### Gemma synthetic data generator ----
  tar_target(
    name = gemma_form2_data_generator,
    command = ellmer::chat_ollama(
      model = gemma_model_name,
      system_prompt = prompt_form2_synthetic_data,
      echo = "none"
    )
  ),

  ### Synthetic data generation ----
  tar_target(
    name = gemma_form2_synthetic_data,
    command = llm_generate_synthetic_data(
      generator = gemma_form2_data_generator,
      prompt = synthetic_data_generation_prompt_list,
      type = output_type_form2_synthetic_data
    ),
    pattern = map(synthetic_data_generation_prompt_list)
  )
)


## gpt form 2 synthetic data generation targets ----
gpt_form2_synthetic_data_targets <- tar_plan(
  ### gpt synthetic data generator ----
  tar_target(
    name = gpt_form2_data_generator,
    command = ellmer::chat_ollama(
      model = gpt_model_name,
      system_prompt = prompt_form2_synthetic_data,
      echo = "none"
    )
  ),

  ### Synthetic data generation ----
  tar_target(
    name = gpt_form2_synthetic_data,
    command = llm_generate_synthetic_data(
      generator = gpt_form2_data_generator,
      prompt = synthetic_data_generation_prompt_list,
      type = output_type_form2_synthetic_data
    ),
    pattern = map(synthetic_data_generation_prompt_list)
  )
)


## llama form2 synthetic data generation targets ----
llama_form2_synthetic_data_targets <- tar_plan(
  ### llama synthetic data generator ----
  tar_target(
    name = llama_form2_data_generator,
    command = ellmer::chat_ollama(
      model = llama_model_name,
      system_prompt = prompt_form2_synthetic_data,
      echo = "none"
    )
  ),

  ### Synthetic data generation ----
  tar_target(
    name = llama_form2_synthetic_data,
    command = llm_generate_synthetic_data(
      generator = llama_form2_data_generator,
      prompt = synthetic_data_generation_prompt_list,
      type = output_type_form2_synthetic_data
    ),
    pattern = map(synthetic_data_generation_prompt_list)
  )
)


## qwen form2 synthetic data generation targets ----
qwen_form2_synthetic_data_targets <- tar_plan(
  ### qwen synthetic data generator ----
  tar_target(
    name = qwen_form2_data_generator,
    command = ellmer::chat_ollama(
      model = qwen_model_name,
      system_prompt = prompt_form2_synthetic_data,
      echo = "none"
    )
  ),

  ### Synthetic data generation ----
  tar_target(
    name = qwen_form2_synthetic_data,
    command = llm_generate_synthetic_data(
      generator = qwen_form2_data_generator,
      prompt = synthetic_data_generation_prompt_list,
      type = output_type_form2_synthetic_data
    ),
    pattern = map(synthetic_data_generation_prompt_list)
  )
)
