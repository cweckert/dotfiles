#!/bin/bash
sudo add-apt-repository ppa:regolith-linux/release
sudo apt update
sudo apt install -y curl vim zsh tmux emacs i3-gaps i3blocks rofi pavucontrol jq evolution kubectx

RUSTDIR="$HOME/.rustup"
if [ ! -d "$RUSTDIR" ]; then
    echo 'Installing rustup'
    /bin/sh -c "$(curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs)" -s -- -y
else
    echo 'Rustup already installed'
fi

NVMDIR="$HOME/.nvm"
if [ ! -d "$NVMDIR" ]; then
    echo 'Installing nvm'
    /bin/sh -c "$(curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh)"
else
    echo 'NVM already installed'
fi

if [ ! -f "$HOME/.local/bin/kubectl" ]; then
    echo 'Install latest kubectl'
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    chmod +x kubectl
    mkdir -p ~/.local/bin/
    mv ./kubectl ~/.local/bin/
fi

# Install Fira Code Font
font_dir="$HOME/.local/share/fonts"
if [ ! -d "$font_dir/FiraCode" ]; then
    echo "Installing Fira Code"
    mkdir -p $font_dir

    FIRACODE="Fira_Code_v5.2.zip"
    curl -LO -s https://github.com/tonsky/FiraCode/releases/download/5.2/$FIRACODE
    unzip $FIRACODE -d $font_dir/FiraCode
    rm $FIRACODE
else
    echo "FiraCode was already installed"
fi

# Check if oh-my-zsh is installed
OMZDIR="$HOME/.oh-my-zsh"
if [ ! -d "$OMZDIR" ]; then
    echo 'Installing oh-my-zsh'
    /bin/sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
else
    echo 'Updating oh-my-zsh'
    omz upgrade
fi

# Change default shell
if [ ! $0 = "-zsh" ]; then
    echo 'Changing default shell to zsh'
    chsh -s /bin/zsh
else
    echo 'Already using zsh'
fi
