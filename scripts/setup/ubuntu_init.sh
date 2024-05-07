#! /bin/bash

sudo apt update -y
sudo apt upgrade -y
sudo apt remove gnome-shell-extension-ubuntu-dock yelp

pushd ~
rmdir Documents/ Music/ Pictures/ Public/ Templates/ Videos/
popd

sudo apt install -y curl
sh <(curl -L https://nixos.org/nix/install) --daemon

powerprofilesctl set performance
