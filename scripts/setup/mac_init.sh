#! /bin/bash

chsh -s /bin/bash

sh <(curl -L https://nixos.org/nix/install)

# open a new terminal window
# copy over SSH key

nix-shell -p git --run 'git clone --bare git@github.com:dbruc3/dotfiles.git ~/.cfg'
git --git-dir=$HOME/.cfg --work-tree=$HOME checkout
nix-shell -p home-manager --run "home-manager switch"

# install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install chromium sparrow

