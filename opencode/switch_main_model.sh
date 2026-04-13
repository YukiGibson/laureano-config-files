#!/bin/bash

# Check if jq is installed
if ! command -v jq &>/dev/null; then
  echo "Error: jq is not installed. Please install it (e.g., brew install jq)."
  exit 0
fi

# Check if an argument is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <model_prefix>"
  echo "Example: $0 gemma-4-26b"
  exit 0
fi

PREFIX=$1
CONFIG_FILE="opencode.json"

# Check if config file exists
if [ ! -f "$CONFIG_FILE" ]; then
  echo "Error: $CONFIG_FILE not found."
  exit 0
fi

# Resolve the full model string (provider/model)
# This query finds the first provider key that starts with the prefix and its first model key.
FULL_MODEL=$(jq -r --arg prefix "$PREFIX" '.provider | to_entries[] | select(.key | startswith($prefix)) | .key + "/" + (.value.models | keys[0])' "$CONFIG_FILE" | head -n 1)

if [ -z "$FULL_MODEL" ] || [ "$FULL_MODEL" == "null" ]; then
  echo "Error: No provider matching prefix '$PREFIX' found in $CONFIG_FILE."
  exit 0
fi

echo "Resolved model: $FULL_MODEL"

# Update opencode.json
# Use a temporary file for jq output to avoid issues on some systems
jq --arg model "$FULL_MODEL" '.model = $model' "$CONFIG_FILE" >"$CONFIG_FILE.tmp" && mv "$CONFIG_FILE.tmp" "$CONFIG_FILE"
echo "Updated $CONFIG_FILE"

# Update agent files
AGENT_FILES=("agents/build.md" "agents/plan.md")

for FILE in "${AGENT_FILES[@]}"; do
  if [ -f "$FILE" ]; then
    # Use | as sed delimiter because FULL_MODEL contains /
    sed -i '' "s|^model: .*|model: $FULL_MODEL|" "$FILE"
    echo "Updated $FILE"
  else
    echo "Warning: $FILE not found, skipping."
  fi
done

echo "Successfully switched main model to $FULL_MODEL."
