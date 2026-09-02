#!/bin/bash

if [ -d "$STOW_DIR" ]; then
	find "$STOW_DIR" -type f -printf '%P\n' | while read -r file; do
		path="$HOME/$file"
		if [ -e "$path" ] || [ -L "$path" ]; then
			echo "[CONFLICT] Removing: $path"
			rm -f "$path"
		fi
	done
fi
