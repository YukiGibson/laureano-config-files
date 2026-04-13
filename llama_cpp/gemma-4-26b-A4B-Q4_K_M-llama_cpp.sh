#!/usr/bin/env zsh

set +x

/home/laureano-3090/Projects/llm_scripts/llama.cpp/build/bin/llama-server \
  -m ~/Projects/models/gemma-4-26B-A4B-it-UD-Q4_K_M.gguf \
  --alias gemma-4-26b-Q4 \
  --n-gpu-layers 999 \
  --host 0.0.0.0 \
  --port 11434 \
  --temp 1.0 \
  --top-p 0.95 \
  --top-k 64 \
  --chat-template-file ~/Projects/llm_scripts/llama.cpp/models/templates/google-gemma-4-31B-it.jinja \
  --chat-template-kwargs '{"enable_thinking":true}'
