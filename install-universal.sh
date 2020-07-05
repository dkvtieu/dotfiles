#! /bin/bash

### --- Neovim --- ###

cp -r --parents .config/nvim ~/

### --- Tmux --- ###

# NOTE: Remember to install plugins after tmux session is started
# See https://github.com/tmux-plugins/tpm#installing-plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

cp .tmux.conf ~/.tmux.conf

### --- ZSH & Oh My Zsh --- ###

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Copy zsh related configuration AFTER installing oh-my-zsh to avoid overwriting
cp .zshrc ~/.zshrc

# Pure prompt
mkdir -p "$HOME/.zsh"
git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"

# ohmyzsh unofficial plugins
git clone https://github.com/paulirish/git-open.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/git-open
git clone https://github.com/lukechilds/zsh-nvm ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-nvm
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
