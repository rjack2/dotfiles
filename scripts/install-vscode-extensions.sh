#!/usr/bin/env bash

set -e

extensions=(
    "vscodevim.vim"
    "haapanen.vs-code-paragraph-hard-wrapper"
    "konstantin.wrapselection"
    "stkb.rewrap"
    "tuxtina.json2yaml"
)

if command -v code >/dev/null 2>&1; then
    for extension in "${extensions[@]}"; do
        echo "Installing VS Code extension: $extension"
        code --install-extension "$extension" || true
    done
fi
