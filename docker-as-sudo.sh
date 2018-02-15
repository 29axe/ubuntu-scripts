#!/bin/bash

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

