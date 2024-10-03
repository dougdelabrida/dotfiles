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

export MANPAGER="nvim +Man!"
export EDITOR='nvim'

for conf in "$HOME/.config/zsh/config.d/"*.zsh; do
  source "${conf}"
done

. /opt/homebrew/opt/asdf/libexec/asdf.sh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/delabrida/.local/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/delabrida/.local/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/delabrida/.local/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/delabrida/.local/google-cloud-sdk/completion.zsh.inc'; fi

# bun completions
[ -s "/Users/delabrida/.bun/_bun" ] && source "/Users/delabrida/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH=$HOME/development/flutter/bin:$PATH
