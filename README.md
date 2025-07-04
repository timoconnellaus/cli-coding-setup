# CLI Coding Setup

A repository for CLI coding setup scripts and configurations for streamlined Git worktree-based development workflows.

## Contents

- **create-worktree.sh** - Interactive Git worktree creation script that automates feature branch setup with consistent naming conventions
- **new-feature.sh** - Creates a new feature worktree and opens a 3-pane iTerm window (helix editor, gitui, claude)
- **close-feature.sh** - Safely closes a feature worktree after validating clean state, with optional branch deletion
- **new-iterm.sh** - Opens a new iTerm window with 3-pane development setup (helix, gitui, claude)
- **setup.sh** - Installs global shell aliases for all scripts

## Installation

Run the setup script to install global aliases:

```bash
./setup.sh
```

This adds the following aliases to your ~/.zshrc:
- `create-worktree` - Create a new Git worktree
- `new-feature` - Create worktree + open development environment
- `close-feature` - Safely close and cleanup feature worktree

## Usage

### Creating a New Feature

```bash
# Interactive mode
new-feature

# Direct mode
new-feature my-feature-name

# With custom Claude command
new-feature my-feature-name "implement user auth"
```

### Working with Worktrees

```bash
# Create worktree only (no iTerm setup)
create-worktree my-feature

# Open development environment in existing directory
new-iterm /path/to/project
new-iterm /path/to/project "run tests"
```

### Closing Features

```bash
# From within a feature worktree directory
close-feature
```

The close-feature script will:
- Verify no uncommitted changes
- Warn about unpushed commits
- Close current iTerm window
- Delete the worktree
- Delete the branch if it has no commits

## Directory Structure

Worktrees are created with the naming pattern: `{project-name}-feat-{feature-name}`

Example: `my-app-feat-user-auth`

## Requirements

- Git with worktree support
- iTerm2 (for terminal automation)
- zsh shell
- Optional: helix editor, gitui, claude CLI