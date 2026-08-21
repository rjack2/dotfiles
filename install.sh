#!/usr/bin/env bash

set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Installing Codespaces dotfiles..."

link() {
    local source="$DOTFILES/$1"
    local target="$HOME/$1"

    if [[ -e "$target" && ! -L "$target" ]]; then
        mv "$target" "$target.codespaces-backup"
    fi

    ln -sfn "$source" "$target"
    echo "Linked $target -> $source"
}

link .zshrc
link .vimrc
link .inputrc

#
# Don't replace Codespaces' entire Git configuration.
# Include our preferences instead.
#
git config --global include.path "$DOTFILES/.gitconfig"

#
# Install personal VS Code extensions.
#
install_vscode_extensions() {
    if ! command -v code >/dev/null 2>&1; then
        echo "VS Code CLI not available; skipping extension installation."
        return
    fi

    local extensions=(
        "vscodevim.vim"
        "haapanen.vs-code-paragraph-hard-wrapper"
        "konstantin.wrapselection"
        "stkb.rewrap"
        "tuxtina.json2yaml"
    )

    for extension in "${extensions[@]}"; do
        echo "Installing VS Code extension: $extension"
        code --install-extension "$extension" --force || \
            echo "Warning: could not install $extension"
    done
}

install_vscode_extensions

#
# Make Zsh the login shell.
#
if command -v zsh >/dev/null 2>&1; then
    sudo chsh "$(id -un)" --shell "$(command -v zsh)"
fi

echo "Dotfiles installation complete."
