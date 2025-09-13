#!/usr/bin/env bash
# A rebuild script that commits on a successful build

pushd ~/mysystem
nvim -p home.nix nixos/configuration.nix flake.nix
alejandra . &>/dev/null
git diff -U0 *.nix
echo "NixOS Rebuilding..."
git update-index --no-assume-unchanged device_specific/* nixos/hardware_configuration.nix
sudo nixos-rebuild switch --flake . --impure
current=$(nixos-rebuild list-generations | grep True | awk '{print $1}')
git update-index --assume-unchanged device_specific/* nixos/hardware_configuration.nix
git commit -am "$current"
popd
notify-send -e "NixOS Rebuilt OK!" --icon=software-update-available
