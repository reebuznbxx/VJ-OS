#!/bin/bash

set -e

# Find the parent directory of the script
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[@]}" )" &>/dev/null && pwd )
STOW_DIR="$SCRIPT_DIR"

# The directories to link
HOME_DIRS=(
	"${XDG_CONFIG_HOME:-$HOME/.config}"
	"$HOME/.local/bin"
)

# Check if directory exists (mkdir if not) AND not a symlink (stow will error if a symlink exists)
for dir in "${HOME_DIRS[@]}"; do
	if [ ! -d "$dir" ]; then
		echo "[MKDIR] $dir"
		mkdir -p "$dir"
	elif [ -L "$dir" ]; then
		echo "[ERROR] $dir: Symlink!" >&2
		exit 1
	fi
done

# Stow mirrors $HOME, so it'll stow the content of $HOME_DIRS instead of the directories themselves
stow -v "$@" -d "$STOW_DIR" -t "$HOME" "home"
