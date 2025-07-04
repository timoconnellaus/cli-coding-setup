#!/bin/bash

# Parse arguments: first arg is path, second arg is claude command
if [ -n "$1" ]; then
    CURRENT_DIR="$1"
else
    CURRENT_DIR=$(pwd)
fi

# Second argument is the claude command
CLAUDE_COMMAND="$2"

# Prepare the claude command
if [ -n "$CLAUDE_COMMAND" ]; then
    CLAUDE_CMD="claude '$CLAUDE_COMMAND'"
else
    CLAUDE_CMD="claude"
fi

# Open a new iTerm window with the same size as the current window
osascript -e "
tell application \"iTerm\"
    # Get the bounds of the current window
    set currentBounds to bounds of current window
    
    # Create new window with default profile
    create window with default profile
    
    # Set the new window to the same size as the current window
    set bounds of current window to currentBounds
    
    # Navigate to the captured directory in the first session and run hx
    tell current session of current tab of current window
        write text \"cd '$CURRENT_DIR'\"
        write text \"hx\"
    end tell
    
    # Split right and run gitui
    tell current session of current tab of current window
        split vertically with default profile
    end tell
    
    # Wait a moment for the split to complete
    delay 0.5
    
    tell second session of current tab of current window
        write text \"cd '$CURRENT_DIR'\"
        write text \"gitui\"
    end tell
    
    # Split down from the gitui pane and run claudecontinue
    tell second session of current tab of current window
        split horizontally with default profile
    end tell
    
    # Wait a moment for the split to complete
    delay 0.5
    
    tell third session of current tab of current window
        write text \"cd '$CURRENT_DIR'\"
        write text \"$CLAUDE_CMD\"
    end tell
    
    # Set focus to the last session (claude)
    tell third session of current tab of current window
        select
    end tell
end tell
"
