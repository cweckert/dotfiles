#!/bin/bash

RUSTDIR="$HOME/.rustup"
if [ ! -d "$RUSTDIR"]; then
    echo 'Installing rustup'
    /bin/sh -c "$(curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs)"
else
    echo 'Rustup already installed'
fi

NVMDIR="$HOME/.nvm"
if [ ! -d "$NVMDIR"]; then
    echo 'Installing nvm'
    /bin/sh -c "$(curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh)"
else
    echo 'NVM already installed'
fi

# Check if oh-my-zsh is installed
OMZDIR="$HOME/.oh-my-zsh"
if [ ! -d "$OMZDIR" ]; then
    echo 'Installing oh-my-zsh'
    /bin/sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
else
    echo 'Updating oh-my-zsh'
    upgrade_oh_my_zsh
fi

# Change default shell
if [! $0 = "-zsh"]; then
    echo 'Changing default shell to zsh'
    chsh -s /bin/zsh
else
    echo 'Already using zsh'
fi
