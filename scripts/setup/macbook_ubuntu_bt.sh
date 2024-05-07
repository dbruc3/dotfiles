#! /bin/bash

pushd ~
sudo apt install dkms gcc git make linux-headers-generic wget
git clone https://github.com/leifliddy/macbook12-bluetooth-driver.git
cd macbook12-bluetooth-driver/
sudo ./install.bluetooth.sh -i
# to uninstall the dkms feature run: ./install.bluetooth.sh -u
sudo apt remove dkms gcc git make linux-headers-generic wget
rm -rf ~/macbook12-bluetooth-driver
sudo reboot
