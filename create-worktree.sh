#!/bin/bash

# Check if we're in the main folder by looking for a parent directory with the base project name
CURRENT_DIR="$(basename "$(pwd)")"
PARENT_DIR="$(dirname "$(pwd)")"

# Extract the base project name (remove any feature suffix)
if [[ "$CURRENT_DIR" =~ ^(.+)-feat-.+ ]]; then
    BASE_PROJECT_NAME="${BASH_REMATCH[1]}"
    # Check if the main project folder exists in the parent directory
    if [ -d "$PARENT_DIR/$BASE_PROJECT_NAME" ]; then
        echo "Error: You appear to be in a feature worktree directory ($CURRENT_DIR)"
        echo "Please run this script from the main project directory: $BASE_PROJECT_NAME"
        echo "Change to the main directory with: cd ../$BASE_PROJECT_NAME"
        exit 1
    fi
fi

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
PROJECT_NAME="$(basename "$(pwd)")"
BRANCH_NAME="feature/$FEATURE_NAME"
WORKTREE_PATH="../${PROJECT_NAME}-feat-${FEATURE_NAME}"

echo "Creating worktree for feature: $FEATURE_NAME"
echo "Branch name: $BRANCH_NAME"
echo "Worktree path: $WORKTREE_PATH"

# Check if worktree directory already exists
if [ -d "$WORKTREE_PATH" ]; then
    echo -e "\033[31mError: Worktree directory already exists: $WORKTREE_PATH\033[0m"
    echo -e "\033[31mPlease remove the existing directory or choose a different feature name\033[0m"
    exit 1
fi

git worktree add -b "$BRANCH_NAME" "$WORKTREE_PATH"

if [ $? -eq 0 ]; then
    echo "Worktree created successfully"
    echo "To change to the worktree directory, run:"
    echo "cd $WORKTREE_PATH"
else
    echo "Failed to create worktree"
    exit 1
fi