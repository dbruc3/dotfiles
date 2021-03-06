#!/usr/bin/sh
echo "Enter IP address for server:"
read server
echo "Alternative SSH port:"
read ssh_port_alt

pkg upgrade -y
pkg install -y bash-completion curl elinks gbt gnupg2 gtypist hub hunspell ledger man mosh mpv mutt neofetch newsboat mathomatic ncdu openssh pass python stow rsync termux* tmux transmission vim units weechat

pip install --upgrade pip
pip3 install khal speedtest-cli youtube-dl geocoder ipgetter python-forecastio termcolor

#SHELL
#chsh

#TERMUX
termux-setup-storage
sleep 5
mv ~/storage ~/.storage

#DOTFILES
cd ~/.dotfiles
stow *

#SSH
ssh-keygen
#cp .ssh/id_rsa.pub .storage/downloads/id_rsa.pub
#read 'Send .storage/downloads/id_rsa.pub to nuc via email (Enter to continue)'
echo "Host nuc" > ~/.ssh/config
echo "\tHostName $server" >> ~/.ssh/config
echo "\tUser dan" >> ~/.ssh/config
echo "Host pi" >> ~/.ssh/config
echo "\tHostName $server" >> ~/.ssh/config
echo "\tPort $ssh_port_alt" >> ~/.ssh/config
echo "\tUser dan" >> ~/.ssh/config
ssh-copyid pi

#GIT
cd ~/.dotfiles
git remote remove origin
git remote add origin git@github.com:dbruc3/dotfiles.git
git push --set-upstream origin master
cp ~/.storage/downloads/id_rsa* ~/.ssh/

#ABOOK
git clone ssh://dan@$server:$ssh_port_alt/home/dan/git/contacts.git ~/.abook/contacts

#KHAL
git clone ssh://dan@$server:$ssh_port_alt/home/dan/git/calendar.git ~/.config/khal/calendar

#PASS
git clone ssh://dan@$server:$ssh_port_alt/home/dan/git/pass.git ~/.password-store
scp -r dan@$server:~/.gnupg/keys ~/keys
gpg2 --import ~/keys/pass.pub.key
gpg2 --import ~/keys/pass.key
rm -rf ~/keys

#broken
#echo 'KEYBASE'
#go get github.com/keybase/client/go/keybase
#go install -tags production github.com/keybase/client/go/keybase
