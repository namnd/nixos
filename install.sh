#!/bin/sh

#################################################
# Bootstrapping NixOS
#################################################

nix-shell -p git

git clone --recurse-submodules https://github.com/namnd/nixos

cd nixos || return

sudo mv /etc/nixos/configuration.nix /etc/nixos/configuration.nix.bak
sudo ln -s "$PWD"/configuration.nix /etc/nixos/configuration.nix

sudo nixos-rebuild switch

#################################################
# Install home-manager
#################################################

ln -sfn ./home-manager ./config/home-manager

nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz home-manager
nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
nix-channel --update
export NIX_PATH="$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}"
nix-shell '<home-manager>' -A install

home-manager switch


#################################################
# Fonts
#################################################
ln -sfn ./fonts ./local/share/fonts


#################################################
# Others
#################################################

ln -sfn ./nixpkgs ./config/nixpkgs
ln -sfn ./nvim/ ./config/nvim
ln -sfn ./ghostty ./config/ghostty
