#!/usr/bin/env zsh

set +x

$HOME/Projects/llm_scripts/llama.cpp/build/bin/llama-server \
	-m $HOME/Projects/models/GLM-4.7-Flash-UD-Q5_K_XL.gguf \
	--alias glm-4.7-flash \
	--n-gpu-layers 999 \
	--ctx-size 32768 \
	--host 0.0.0.0 \
	--port 11434 \
	--temp 0.7 \
	--top-p 1.0 \
	--min-p 0.01
