#!/bin/bash

BIN_DIR="$STOW_DIR/.local/bin"
if [ -d "$BIN_DIR" ]; then
    echo "[CHMOD] Making bin executable!"
    find "$BIN_DIR" -type f -exec chmod +x {} +
else
    echo "[ERROR] Binaries not found :<"
    exit 1
fi
