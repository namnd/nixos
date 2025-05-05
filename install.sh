#!/bin/sh

#################################################
# Bootstrapping NixOS
#################################################

sudo mv /etc/nixos/configuration.nix /etc/nixos/configuration.nix.bak
sudo ln -s "$PWD"/configuration.nix /etc/nixos/configuration.nix

sudo nixos-rebuild switch

#################################################
# Install home-manager
#################################################

mkdir -p "$HOME"/.config
ln -sfn "$PWD"/home-manager "$HOME"/.config/home-manager

nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz home-manager
nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
nix-channel --update
export NIX_PATH="$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}"
nix-shell '<home-manager>' -A install

home-manager switch


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
