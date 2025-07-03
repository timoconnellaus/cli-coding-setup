# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a CLI Coding Setup repository containing shell scripts for development workflow automation, specifically focused on Git worktree management for feature development.

## Architecture

**Tech Stack**: Pure shell/bash scripting with Git integration - no external dependencies or build processes required.

**Core Component**: `create-worktree.sh` - Interactive Git worktree creation script that automates feature branch setup with consistent naming conventions.

## Key Commands

### Running the Worktree Script
```bash
# Interactive mode
./create-worktree.sh

# Direct command mode  
./create-worktree.sh feature-name
```

### Validation Rules
- Feature names must be in kebab-case format (lowercase letters, numbers, hyphens only)
- Script validates input and provides clear error messages for invalid formats

## Project-Specific Details

**Target Project**: Designed for "create-tsrouter-app" project workflow
**Branch Strategy**: Creates feature branches with `feature/` prefix
**Directory Structure**: Creates worktrees as `../create-tsrouter-app-feature-name`

## Development Notes

- Scripts are executable and ready to run
- No build process or dependency installation required
- All error handling and validation is built into the scripts
- The codebase is minimal and focused on a single workflow automation task