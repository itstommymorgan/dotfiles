# only wait 10ms for additional characters in a sequence.
export KEYTIMEOUT=1

export BAT_THEME="Dracula"

# load custom configurations
for file in ~/.zsh/custom/*.zsh; do
  source "$file"
done

# load plugins
source $ZSH/plug.zsh

