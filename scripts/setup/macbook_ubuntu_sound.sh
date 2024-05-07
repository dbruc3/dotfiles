#! /bin/bash

pushd ~
sudo apt install gcc git make linux-headers-generic wget
git clone https://github.com/leifliddy/macbook12-bluetooth-driver.git
cd snd_hda_macbookpro/
sudo ./install.cirrus.driver.sh
sudo apt remove gcc git make linux-headers-generic wget
sudo rm -rf ~/snd_hda_macbookpro
sudo reboot
