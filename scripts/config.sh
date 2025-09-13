#!/usr/bin/env bash
# A rebuild script that commits on a successful build
set -e

pushd ~/mysystem
nvim -p home.nix nixos/configuration.nix flake.nix
alejandra . &>/dev/null
git diff -U0 *.nix
echo "NixOS Rebuilding..."
sudo nixos-rebuild switch --flake . --impure
current=$(nixos-rebuild list-generations | grep True | awk '{print $1}')
git commit -am "$current"
popd
notify-send -e "NixOS Rebuilt OK!" --icon=software-update-available
