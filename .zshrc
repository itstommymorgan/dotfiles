export ZSH="$HOME/.oh-my-zsh"

# only wait 10ms for additional characters in a sequence.
export KEYTIMEOUT=1

ZSH_THEME="dracula"
export BAT_THEME="Dracula"

plugins=(asdf direnv git git-open rake-fast virtualenv vi-mode zsh-autosuggestions zsh-completions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# inc homebrew binaries for arm64 macs
export PATH="/opt/homebrew/bin:$PATH"
# inc python user packages
export PATH="$PATH:$HOME/Library/Python/3.8/bin"
# inc local path
export PATH="$PATH:$HOME/.local/bin"

