export ZSH="$HOME/.zsh"

export BREW_ROOT="/usr/local"
if [[ `uname -m` == 'arm64' ]]; then
  export BREW_ROOT="/opt/homebrew"
fi

eval $($BREW_ROOT/bin/brew shellenv)

# put homebrew binaries at front of PATH
export PATH="${BREW_ROOT}/bin:$PATH"

source $(brew --prefix)/opt/zplug/init.zsh

# and add local python packages
export PATH="$PATH:$HOME/Library/Python/3.9/bin"

# only wait 10ms for additional characters in a sequence.
export KEYTIMEOUT=1

export BAT_THEME="Dracula"

# load custom configurations
for file in ~/.zsh/custom/*.zsh; do
  source "$file"
done

# load plugins
source $ZSH/plug.zsh

