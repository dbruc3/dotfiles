#!/data/data/com.termux/files/usr/bin/sh
pkg upgrade
pkg install curl ledger man mosh mpv mutt newsboat openssh python stow termux-api tmux vim youtube-dl zsh

pip install khal speedtest

#SHELL
chsh

#TERMUX
termux-setup-storage
mv storage .storage

#DOTFILES
cd ~/.dotfiles
stow *

#SSH
ssh-keygen
#cp .ssh/id_rsa.pub .storage/downloads/id_rsa.pub
#read 'Send .storage/downloads/id_rsa.pub to nuc via email (Enter to continue)'

