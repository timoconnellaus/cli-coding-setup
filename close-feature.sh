#!/bin/bash

# Get the current directory name
CURRENT_DIR="$(basename "$(pwd)")"
PARENT_DIR="$(dirname "$(pwd)")"

# Check if we're in a feature worktree directory
if [[ ! "$CURRENT_DIR" =~ ^(.+)-feat-.+ ]]; then
    echo -e "\033[31mError: You don't appear to be in a feature worktree directory\033[0m"
    echo "This script should be run from a directory matching the pattern: {project}-feat-{feature}"
    exit 1
fi

# Extract the base project name and feature name
BASE_PROJECT_NAME="${BASH_REMATCH[1]}"
FEATURE_NAME="${CURRENT_DIR#*-feat-}"

# Check if the main project folder exists
MAIN_PROJECT_PATH="$PARENT_DIR/$BASE_PROJECT_NAME"
if [ ! -d "$MAIN_PROJECT_PATH" ]; then
    echo -e "\033[31mError: Main project directory not found: $MAIN_PROJECT_PATH\033[0m"
    exit 1
fi

# Check if git status is clean
if ! git diff --quiet || ! git diff --cached --quiet; then
    echo -e "\033[31mError: Working directory is not clean\033[0m"
    echo "Please commit or stash your changes before closing the feature"
    git status
    exit 1
fi

# Check for untracked files
if [ -n "$(git ls-files --others --exclude-standard)" ]; then
    echo -e "\033[31mError: There are untracked files in the working directory\033[0m"
    echo "Please commit or remove untracked files before closing the feature"
    git status
    exit 1
fi

echo "Closing feature: $FEATURE_NAME"
echo "Main project: $BASE_PROJECT_NAME"
echo "Working directory is clean"

# Check if there are unpushed commits
BRANCH_NAME="feature/$FEATURE_NAME"
if git rev-list --count HEAD ^origin/$BRANCH_NAME 2>/dev/null | grep -q '^[1-9]' || ! git rev-parse --verify origin/$BRANCH_NAME 2>/dev/null; then
    echo -e "\033[33mWarning: Branch has unpushed commits or doesn't exist on remote\033[0m"
    echo "Are you sure you want to close this feature? [y/N]"
    read -r CONFIRM
    if [[ ! "$CONFIRM" =~ ^[Yy]$ ]]; then
        echo "Closing cancelled"
        exit 0
    fi
fi

# Close current iTerm window and open a single terminal in main project
osascript -e "
tell application \"iTerm\"
    # Close current window
    close current window
    
    # Create a simple new window with one terminal
    create window with default profile
    
    # Navigate to main project and delete the worktree
    tell current session of current tab of current window
        write text \"cd '$MAIN_PROJECT_PATH'\"
        write text \"git worktree remove '../$CURRENT_DIR'\"
        write text \"if git rev-list --count feature/$FEATURE_NAME ^HEAD | grep -q '^0$'; then git branch -d feature/$FEATURE_NAME && echo 'Deleted empty branch feature/$FEATURE_NAME'; else echo 'Branch feature/$FEATURE_NAME has commits, keeping it'; fi\"
        write text \"echo 'Feature $FEATURE_NAME closed successfully'\"
        write text \"exit\"
    end tell
end tell
"