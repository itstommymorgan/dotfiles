export ZSH="$HOME/.zsh"

# Why do I do all this? Sigh. The short version is that if I'm starting zsh in
# a login shell, then my .zshrc file is the best place to setup homebrew - it's
# after the OS does all of its default pathing stuff (in /etc/zprofile). If it's
# NOT a login shell, however, .zshrc doesn't get loaded - so I need to do
# it in .zshenv in order to make sure we have the right path order in place (otherwise
# scripts start to fail).
__tm_setup_homebrew() {
  export BREW_ROOT="/usr/local"
  if [[ `uname -m` == 'arm64' ]]; then
    export BREW_ROOT="/opt/homebrew"
  fi

  eval $(${BREW_ROOT}/bin/brew shellenv)
}

[[ ! -o interactive ]] && __tm_setup_homebrew
