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
# Make Zsh the login shell.
#
if command -v zsh >/dev/null 2>&1; then
    sudo chsh "$(id -un)" --shell "$(command -v zsh)"
fi

echo "Dotfiles installation complete."