### --- Oh My Zsh --- ###
#
export NVM_LAZY_LOAD=true

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME=""

export BAT_THEME='Dracula'

plugins=(
    # Official plugins
    git
    colored-man-pages
    # Unofficial plugins
    git-open
    zsh-nvm
    zsh-syntax-highlighting
    zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

### --- Theming --- ###

# Pure prompt
# https://github.com/sindresorhus/pure
fpath+=$HOME/.zsh/pure
autoload -U promptinit; promptinit
prompt pure

### --- User configuration --- ###


# Disable marking untracked files under VCS as dirty
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Loading user aliases
source $HOME/.aliases

[[ $TMUX != "" ]] && export TERM="screen-256color"
