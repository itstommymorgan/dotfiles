export ZSH="$HOME/.zsh"

export BREW_ROOT="/usr/local"
if [[ `uname -m` == 'arm64' ]]; then
  export BREW_ROOT="/opt/homebrew"
fi

# put homebrew binaries at front of PATH
export PATH="${BREW_ROOT}/bin:$PATH"
# and add local python packages
export PATH="$PATH:$HOME/Library/Python/3.8/bin"

