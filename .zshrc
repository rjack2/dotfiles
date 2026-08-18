# ~/.zshrc
#
# GitHub Codespaces configuration

# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS

# Completion
autoload -Uz compinit
compinit

# Navigation
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS

# Editor
export EDITOR=vim
export VISUAL=vim

# Go
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$HOME/.local/bin:$PATH"

# mise, when installed
if command -v mise >/dev/null 2>&1; then
    eval "$(mise activate zsh)"
fi

# Useful aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --decorate --graph'

# Private configuration, if one is manually provided
if [[ -f "$HOME/.zshrc-private" ]]; then
    source "$HOME/.zshrc-private"
fi