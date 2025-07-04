#!/bin/bash

# Get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Parse arguments: first arg is feature name, second arg is claude command
FEATURE_NAME="$1"
CLAUDE_COMMAND="$2"

# Run create-worktree.sh and capture the output (pass only the feature name)
OUTPUT=$("$SCRIPT_DIR/create-worktree.sh" "$FEATURE_NAME")
EXIT_CODE=$?

# Print the output
echo "$OUTPUT"

# If create-worktree succeeded, open new iTerm window
if [ $EXIT_CODE -eq 0 ]; then
    # Extract the feature name from the arguments or prompt
    if [ -z "$FEATURE_NAME" ]; then
        echo "Enter feature name (kebab-case):"
        read -r FEATURE_NAME
    fi
    
    # Calculate the worktree path (same logic as create-worktree.sh)
    PROJECT_NAME="$(basename "$(pwd)")"
    WORKTREE_PATH="../${PROJECT_NAME}-feat-${FEATURE_NAME}"
    
    # Get the absolute path of the worktree
    ABSOLUTE_WORKTREE_PATH=$(cd "$WORKTREE_PATH" && pwd)
    
    # Open new iTerm window with the worktree and claude command
    "$SCRIPT_DIR/new-iterm.sh" "$ABSOLUTE_WORKTREE_PATH" "$CLAUDE_COMMAND"
else
    exit $EXIT_CODE
fi