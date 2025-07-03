#!/bin/bash

if [ -z "$1" ]; then
    echo "Enter feature name (kebab-case):"
    read -r FEATURE_NAME
    if [ -z "$FEATURE_NAME" ]; then
        echo "Feature name cannot be empty"
        exit 1
    fi
else
    FEATURE_NAME="$1"
fi

# Check if feature name is in kebab-case format
if [[ ! "$FEATURE_NAME" =~ ^[a-z0-9]+(-[a-z0-9]+)*$ ]]; then
    echo "Error: Feature name must be in kebab-case format (lowercase letters, numbers, and hyphens only)"
    echo "Example: github-extension, user-auth, api-client"
    exit 1
fi
PROJECT_NAME="create-tsrouter-app"
BRANCH_NAME="feature/$FEATURE_NAME"
WORKTREE_PATH="../${PROJECT_NAME}-${FEATURE_NAME}"

echo "Creating worktree for feature: $FEATURE_NAME"
echo "Branch name: $BRANCH_NAME"
echo "Worktree path: $WORKTREE_PATH"

git worktree add -b "$BRANCH_NAME" "$WORKTREE_PATH"

if [ $? -eq 0 ]; then
    echo "Worktree created successfully"
    echo "To change to the worktree directory, run:"
    echo "cd $WORKTREE_PATH"
else
    echo "Failed to create worktree"
    exit 1
fi