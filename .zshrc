export ZSH="$HOME/.zsh"

brew_root="/usr/local"
if [[ `uname -m` == 'arm64' ]]; then
  brew_root="/opt/homebrew"
fi

# only wait 10ms for additional characters in a sequence.
export KEYTIMEOUT=1

export BAT_THEME="Dracula"

# put homebrew binaries at front of PATH
export PATH="${brew_root}/bin:$PATH"

# load custom configurations
for file in ~/.zsh/custom/*.zsh; do
  source "$file"
done

# load plugins
source $ZSH/plug.zsh

