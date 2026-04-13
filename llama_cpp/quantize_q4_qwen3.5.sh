#!/bin/bash
set -euo pipefail

MODEL_PATH="$HOME/Projects/models/models--Jackrong--Qwen3.5-27B-Claude-4.6-Opus-Reasoning-Distilled-v2-GGUF/snapshots"
SNAPSHOT=$(ls "$MODEL_PATH")
LLAMA_CPP="$HOME/Projects/llm_scripts/llama.cpp"
OUTPUT_DIR="$HOME/Projects/models"

GGUF="$OUTPUT_DIR/qwen3.5-27b-claude-v2.gguf"
GGUF_Q4="$OUTPUT_DIR/qwen3.5-27b-claude-Q4_K_M-v2.gguf"

echo "Converting to GGUF..."
python "$LLAMA_CPP/convert_hf_to_gguf.py" "$MODEL_PATH/$SNAPSHOT" --outfile "$GGUF"

echo "Quantizing to Q4_K_M..."
"$LLAMA_CPP/build/bin/llama-quantize" "$GGUF" "$GGUF_Q4" Q4_K_M

echo "Removing unquantized GGUF..."
rm "$GGUF"

echo "Done: $GGUF_Q4"
