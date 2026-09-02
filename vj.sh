#!/bin/bash

# Find the parent directory of the script
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[@]}" )" &>/dev/null && pwd )
STOW_DIR="$SCRIPT_DIR/home"

export STOW_DIR

$SCRIPT_DIR/scripts/chmod-bin.sh
$SCRIPT_DIR/scripts/symlink.sh "$1" # In case of -D
