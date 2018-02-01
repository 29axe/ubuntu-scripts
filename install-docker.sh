#!/bin/bash

# uninstall older versions
sudo apt remove docker docker-engine docker.io

## remove previous config
sudo rm -r /home/"$USER"/.docker

# set up the repository
sudo apt udpate

## install required dependencies
sudo apt install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

## add docker official gpg key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88

## add repository
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# install docker
sudo apt update
sudo apt install -y docker-ce

# add user as sudo
while true; do
	read -p "Do you want to manage docker without root? (This will add your user to the docker group): (y/N): " -n 1 -r choice
	echo    # move to a new line
    case $choice in
        [Yy]* ) 
		sudo groupadd docker
		sudo usermod -aG docker $USER
		echo "User added to docker group."
		## reboot computer
		while true; do
			read -p "You need to restart your computer. Do you want to do it now? (y/N): " -n 1 -r choice
			echo    # move to a new line
		    case $choice in
			[Yy]* ) 
				sudo reboot
				break;;
			""|[Nn]* ) exit 0;;
			* ) echo "Invalid character. Type y or n only.";;
		    esac
		done
		break;;
        ""|[Nn]* ) exit 0;;
        * ) echo "Invalid character. Type y or n only.";;
    esac
done

