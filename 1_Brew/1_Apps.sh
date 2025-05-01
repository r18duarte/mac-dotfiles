##################
# Setup terminal #
##################

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install powerline10k
echo "source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme" >>~/.zshrc

# Symlink .zshrc to home folder
mv ~/.zshrc ~/.zshrc_back
ln -s ~/dotfiles/.zshrc ~/.zshrc

#################
# Neovim config #
#################

# backup default config
mv ~/.config/nvim{,.bak}

# symlink to nvim config folder
ln -s ~/dotfiles/nvim ~/.config/nvim
