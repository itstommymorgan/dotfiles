source ${brew_root}/opt/zplug/init.zsh

zplug "dracula/zsh", use:"dracula.zsh-theme"
# plugins=(vi-mode)

zplug "plugins/git", from:oh-my-zsh

# Enable `git open` command
zplug "paulirish/git-open"

# Enable faster parsing for `rake` commands
zplug "unixorn/rake-completion.zshplugin"

# vi mode, of course
zplug "jeffreytse/zsh-vi-mode"

# Auto-suggest completions for commands
zplug "zsh-users/zsh-autosuggestions"

# Auto-match paired punctuation (e.g. ' " and ())
zplug "hlissner/zsh-autopair", defer:2

# Syntax highlighting!
zplug "zsh-users/zsh-syntax-highlighting", defer:2

zplug load
