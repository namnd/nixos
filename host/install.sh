#!/bin/sh

mkdir -p $HOME/.config

ln -sfn "${PWD}/hammerspoon" "${HOME}/.hammerspoon"
ln -sfn "${PWD}/qutebrowser" "${HOME}/.qutebrowser"
ln -sfn "${PWD}/kitty" "${HOME}/.config/kitty"
ln -sfn "${PWD}/nixpkgs" "${HOME}/.config/nixpkgs"
ln -sfn "${PWD}/zshrc" "${HOME}/.zshrc"