#!/bin/bash
# language selection
while true; do
	echo "Please, select your language."
	echo 
	# create an array with all the files/dirs inside supported.d
	lang=(/var/lib/locales/supported.d/*)

	# iterate through array using a counter
	for ((i=0; i<${#lang[@]}; i++)); do
	    #do something to each element of array
	    echo "[$i] "$(basename "${lang[$i]}")
	done
	read -p "Language (select a number from the list): " -r language
	echo    # move to a new line
	case $language in
	[0-${#lang[@]}]* ) 
		IFS=$'\r\n' GLOBIGNORE='*' command eval  'locales=($(cat ${lang[language]}))'
		for ((i=0; i<${#locales[@]}; i++)); do
		    #do something to each element of array
		    echo "[$i] "${locales[$i]}
		done
		break;;
	* ) echo "Invalid option. Try again.";;
	esac
done

# update locale to fr_CH
sudo locale-gen fr_CH.UTF-8 
sudo update-locale \
	LANG=fr_CH.UTF-8 \
	LC_CTYPE=fr_CH.UTF-8 \
	LC_NUMERIC=fr_CH.UTF-8 \
	LC_TIME=fr_CH.UTF-8 \
	LC_COLLATE=fr_CH.UTF-8 \
	LC_MONETARY=fr_CH.UTF-8 \
	LC_MESSAGES=en_US.UTF-8 \
	LC_PAPER=fr_CH.UTF-8 \
	LC_NAME=fr_CH.UTF-8 \
	LC_ADDRESS=fr_CH.UTF-8 \
	LC_TELEPHONE=fr_CH.UTF-8 \
	LC_MEASUREMENT=fr_CH.UTF-8 \
	LC_IDENTIFICATION=en_US.UTF-8 

sudo rm /home/"$USER"/.pam_environment
sudo cat > /home/"$USER"/.pam_environment << EOF
LANGUAGE        DEFAULT=fr_CH:en
LANG    DEFAULT=fr_CH.UTF-8
LC_NUMERIC      DEFAULT=fr_CH.UTF-8
LC_TIME DEFAULT=fr_CH.UTF-8
LC_MONETARY     DEFAULT=fr_CH.UTF-8
LC_PAPER        DEFAULT=fr_CH.UTF-8
LC_NAME DEFAULT=fr_CH.UTF-8
LC_ADDRESS      DEFAULT=fr_CH.UTF-8
LC_TELEPHONE    DEFAULT=fr_CH.UTF-8
LC_MEASUREMENT  DEFAULT=fr_CH.UTF-8
LC_IDENTIFICATION       DEFAULT=fr_CH.UTF-8
PAPERSIZE       DEFAULT=letter
EOF

# set language in terminal to english
grep -q -F 'export LANG=C' /home/"$USER"/.bashrc || echo -e "export LANG=C" | sudo tee -a /home/"$USER"/.bashrc >/dev/null

# confirmation
echo "Locale changed to fr_CH.UTF8"

# reboot computer
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
