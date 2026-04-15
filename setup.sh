##!/usr/bin/env bash

set -e

# Install ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Theme
cp assets/robbyrussell.zsh-theme ~/.oh-my-zsh/themes/robbyrussell.zsh-theme

# ohmyzsh config
cp assets/.z.zshrc ~/
