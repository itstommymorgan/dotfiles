# completion and some niceties for AWS CLI
zplug "eastokes/aws-plugin-zsh"

# Complete all the things
zplug "zsh-users/zsh-completions"

# Docker completions
zplug "greymd/docker-zsh-completion"

# Blaaaaaah
zplug "dracula/zsh", use:"dracula.zsh-theme"

# Exa seems cool
zplug "MohamedElashri/exa-zsh"

# EMOJI
zplug "pschmitt/emoji-fzf.zsh"

# Use FZF for history search (Ctrl+R)
zplug "joshskidmore/zsh-fzf-history-search"

# Git helpers stolen from omz
zplug "plugins/git", from:oh-my-zsh

# Enable `git open` command
zplug "paulirish/git-open"

# Add completions for keybase
zplug "rbirnie/oh-my-zsh-keybase"

# Completions for 1password commandline
zplug "sirhc/op.plugin.zsh"

# Add rails aliases/commands
zplug "paraqles/zsh-plugin-rails"

# Enable faster parsing for `rake` commands
zplug "unixorn/rake-completion.zshplugin"

# Wrapper for terraform
zplug "jsporna/terraform-zsh-plugin"

# Sane wrapper for tmux
zplug "kjhaber/tm.zsh"

# Remind me if I forgot my aliases
zplug "MichaelAquilina/zsh-you-should-use"

# vi mode, of course
zplug "jeffreytse/zsh-vi-mode"

# Auto-suggest completions for commands
zplug "zsh-users/zsh-autosuggestions"

# Auto-match paired punctuation (e.g. ' " and ())
zplug "hlissner/zsh-autopair", defer:3

# Syntax highlighting!
zplug "zsh-users/zsh-syntax-highlighting", defer:3

zplug load
