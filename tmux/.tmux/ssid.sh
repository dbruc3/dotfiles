#! /bin/bash

termux-wifi-connectioninfo | grep \"ssid\" | cut -d'"' -f4
