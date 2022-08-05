plugins=(
  git
  zsh-autosuggestions
)

export PATH="$HOME/.asdf/bin:$HOME/.asdf/shims:$PATH:$HOME/dotfiles"
PATH=$PATH:~/.local/bin

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="spaceship"

source $ZSH/oh-my-zsh.sh

export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

export MANPAGER="nvim +Man!"
export EDITOR='nvim'

