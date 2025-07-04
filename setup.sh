#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ZSHRC_PATH="$HOME/.zshrc"

# Main worktree alias
ALIAS_NAME="create-worktree"
ALIAS_COMMAND="alias $ALIAS_NAME='$SCRIPT_DIR/create-worktree.sh'"

# New feature alias
NEW_FEATURE_ALIAS_NAME="new-feature"
NEW_FEATURE_ALIAS_COMMAND="alias $NEW_FEATURE_ALIAS_NAME='$SCRIPT_DIR/new-feature.sh'"

# Close feature alias
CLOSE_FEATURE_ALIAS_NAME="close-feature"
CLOSE_FEATURE_ALIAS_COMMAND="alias $CLOSE_FEATURE_ALIAS_NAME='$SCRIPT_DIR/close-feature.sh'"


ENV_VAR_NAME="CLI_CODING_SETUP_PATH"
ENV_VAR_COMMAND="export $ENV_VAR_NAME='$SCRIPT_DIR'"

echo "Setting up CLI Coding Setup..."

# Check if .zshrc exists
if [ ! -f "$ZSHRC_PATH" ]; then
    echo "Creating .zshrc file..."
    touch "$ZSHRC_PATH"
fi

# Check if main alias already exists
if grep -q "alias $ALIAS_NAME=" "$ZSHRC_PATH"; then
    echo "Alias '$ALIAS_NAME' already exists in .zshrc - skipping"
else
    echo "Adding alias '$ALIAS_NAME' to .zshrc..."
    echo "" >> "$ZSHRC_PATH"
    echo "# CLI Coding Setup" >> "$ZSHRC_PATH"
    echo "$ALIAS_COMMAND" >> "$ZSHRC_PATH"
    echo "Alias added successfully!"
fi

# Check if new-feature alias already exists
if grep -q "alias $NEW_FEATURE_ALIAS_NAME=" "$ZSHRC_PATH"; then
    echo "Alias '$NEW_FEATURE_ALIAS_NAME' already exists in .zshrc - skipping"
else
    echo "Adding alias '$NEW_FEATURE_ALIAS_NAME' to .zshrc..."
    echo "$NEW_FEATURE_ALIAS_COMMAND" >> "$ZSHRC_PATH"
    echo "New feature alias added successfully!"
fi

# Check if close-feature alias already exists
if grep -q "alias $CLOSE_FEATURE_ALIAS_NAME=" "$ZSHRC_PATH"; then
    echo "Alias '$CLOSE_FEATURE_ALIAS_NAME' already exists in .zshrc - skipping"
else
    echo "Adding alias '$CLOSE_FEATURE_ALIAS_NAME' to .zshrc..."
    echo "$CLOSE_FEATURE_ALIAS_COMMAND" >> "$ZSHRC_PATH"
    echo "Close feature alias added successfully!"
fi


# Check if environment variable already exists
if grep -q "export $ENV_VAR_NAME=" "$ZSHRC_PATH"; then
    echo "Environment variable '$ENV_VAR_NAME' already exists in .zshrc - skipping"
else
    echo "Adding environment variable '$ENV_VAR_NAME' to .zshrc..."
    echo "$ENV_VAR_COMMAND" >> "$ZSHRC_PATH"
    echo "Environment variable added successfully!"
fi

echo "Run 'source ~/.zshrc' or restart your terminal to use the alias and environment variable"

echo "Setup complete!"