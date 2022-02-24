#! /bin/bash

### --- Tmux --- ###

  # NOTE: Remember to install plugins after tmux session is started
  # See https://github.com/tmux-plugins/tpm#installing-plugins
if [ ! -d "$HOME/.tmux" ] ; then
  mkdir -p ~/.tmux/plugins
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

### --- ZSH --- ###

if [ ! -d "$HOME/.zsh" ] ; then
  # Install oh-my-zsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  # Create the .zsh folder
  mkdir -p "$HOME/.zsh"
  # Pure prompt
  git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"

  # ohmyzsh unofficial plugins
  git clone https://github.com/paulirish/git-open.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/git-open
  git clone https://github.com/lukechilds/zsh-nvm ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-nvm
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

