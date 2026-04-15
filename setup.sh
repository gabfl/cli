#!/usr/bin/env bash
set -e

# --- Dependency check ---
for cmd in curl git zsh; do
  command -v "$cmd" &>/dev/null || { echo "Error: '$cmd' is not installed"; exit 1; }
done

# --- Validate assets ---
for f in assets/robbyrussell.zsh-theme assets/.zshrc; do
  [ -f "$f" ] || { echo "Error: Missing file '$f'"; exit 1; }
done

# --- Backup existing .zshrc ---
if [ -f "$HOME/.zshrc" ]; then
  backup="$HOME/.zshrc.backup.$(date +%Y%m%d%H%M%S)"
  echo "-> Backing up existing .zshrc to $backup"
  cp "$HOME/.zshrc" "$backup"
fi

# --- Oh My Zsh ---
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "-> Installing Oh My Zsh"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  echo "-> Oh My Zsh already installed, skipping"
fi

# --- zsh-autosuggestions ---
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  echo ""
  echo "-> Cloning zsh-autosuggestions"
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
else
  echo "-> zsh-autosuggestions already installed, skipping"
fi

# --- Theme & config ---
echo ""
echo "-> Replacing theme"
cp assets/robbyrussell.zsh-theme "$HOME/.oh-my-zsh/themes/robbyrussell.zsh-theme"

echo ""
echo "-> Replacing Oh My Zsh config file"
cp assets/.zshrc "$HOME/"

echo ""
echo "Done!"
