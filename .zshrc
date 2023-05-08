# See .zshenv - this is always safe to directly call since it's only called in
# .zshenv if the shell isn't interactive. This file is only loaded for
# interactive shells.
__tm_setup_homebrew

source $(brew --prefix)/opt/zplug/init.zsh

# and add local python packages
export PATH="$PATH:$HOME/Library/Python/3.9/bin"

# only wait 10ms for additional characters in a sequence.
export KEYTIMEOUT=1

export BAT_THEME="Dracula"

export LC_ALL=en_US.UTF-8

# load custom configurations
for file in ~/.zsh/custom/*.zsh; do
  source "$file"
done

# load plugins
source $ZSH/plug.zsh
