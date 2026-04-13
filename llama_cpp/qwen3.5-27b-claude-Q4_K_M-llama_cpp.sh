#!/usr/bin/env zsh

set +x

$HOME/Projects/llm_scripts/llama.cpp/build/bin/llama-server \
	-m $HOME/Projects/models/qwen3.5-27b-claude-Q4_K_M.gguf \
	--alias qwen3.5-27b-claude-Q4 \
	--n-gpu-layers 999 \
	--host 0.0.0.0 \
	--port 11434
