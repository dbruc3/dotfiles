#!/data/data/com.termux/files/usr/bin/sh
pkg upgrade
pkg install curl ledger man mosh mpv mutt newsboat openssh python stow termux-api tmux vim zsh

pip install khal speedtest-cli youtube-dl

#SHELL
chsh

#TERMUX
termux-setup-storage
sleep 5
mv ~/.storage ~/.storage

#DOTFILES
cd ~/.dotfiles
stow *

#SSH
ssh-keygen
#cp .ssh/id_rsa.pub .storage/downloads/id_rsa.pub
#read 'Send .storage/downloads/id_rsa.pub to nuc via email (Enter to continue)'

#Git
cd ~/.dotfiles
git remote remove origin
git remote add origin git@github.com:dbruc3/dotfiles.git
cp ~/.storage/downloads/id_rsa* ~/.ssh/
