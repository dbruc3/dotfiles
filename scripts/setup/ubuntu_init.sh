#! /bin/bash

sudo apt update -y
sudo apt upgrade -y
sudo apt remove gnome-shell-extension-ubuntu-dock yelp

sudo apt install -y curl
sh <(curl -L https://nixos.org/nix/install) --daemon

powerprofilesctl set performance
