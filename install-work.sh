#!/bin/sh

#################################################
# Install Nix
#################################################
export NIX_SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
sh <(curl -L https://nixos.org/nix/install) --daemon

#################################################
# Install home-manager
#################################################

mkdir -p "$HOME"/.config
ln -sfn "$PWD"/home-manager-work "$HOME"/.config/home-manager

nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install

#################################################
# Fonts
#################################################

mkdir -p "$HOME"/.local/share
ln -sfn "$PWD"/fonts "$HOME"/.local/share/fonts
sudo fc-cache


#################################################
# Others
#################################################

ln -sfn "$PWD"/nixpkgs "$HOME"/.config/nixpkgs
ln -sfn "$PWD"/nvim "$HOME"/.config/nvim
ln -sfn "$PWD"/ghostty "$HOME"/.config/ghostty
ln -sfn "$PWD"/xsessionrc "$HOME"/.xsessionrc
