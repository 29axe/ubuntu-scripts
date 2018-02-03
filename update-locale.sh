#!/bin/bash

while true; do
	echo "Select your desired language (country is selected later)."
	# create an array with all the files/dirs inside supported.d
	lang=(/var/lib/locales/supported.d/*)

	for ((i=0; i<${#lang[@]}; i++)); do
	    echo "[$i] "$(basename "${lang[$i]}")
	done

	# user input
	read -p "Language (select a number from the list): " -r language
	echo    # move to a new line
	if [ "$language" -lt "${#lang[@]}" ];
	then
		while true; do
			echo "Select your desired locale."
			IFS=$'\r\n' GLOBIGNORE='*' command eval  'locales=($(cat ${lang[$language]}))'
			for ((i=0; i<${#locales[@]}; i++)); do
			    echo "[$i] ${locales[$i]}"
			done
			
			# user input
			read -p "Language (select a number from the list): " -r locale
			echo    # move to a new line
			if [ "$locale" -lt "${#locales[@]}" ];
			then
				arr=(${locales[$locale]})
				selected_locale="${arr[0]}"
				echo "You chose $selected_locale"
				IFS="."
				set -- $selected_locale
				arr=( $@ )

				short_locale="${arr[0]}"
				# update locale 
				sudo locale-gen "$selected_locale" 
				sudo update-locale \
					LANG="$selected_locale" \
					LC_CTYPE="$selected_locale" \
					LC_NUMERIC="$selected_locale" \
					LC_TIME="$selected_locale" \
					LC_COLLATE="$selected_locale" \
					LC_MONETARY="$selected_locale" \
					LC_MESSAGES=en_US.UTF-8 \
					LC_PAPER="$selected_locale" \
					LC_NAME="$selected_locale" \
					LC_ADDRESS="$selected_locale" \
					LC_TELEPHONE="$selected_locale" \
					LC_MEASUREMENT="$selected_locale" \
					LC_IDENTIFICATION=en_US.UTF-8 

				sudo rm /home/"$USER"/.pam_environment
				sudo cat > /home/"$USER"/.pam_environment << EOF
LANGUAGE        DEFAULT=${short_locale}:en
LANG    DEFAULT=${selected_locale}
LC_NUMERIC      DEFAULT=${selected_locale}
LC_TIME DEFAULT=${selected_locale}
LC_MONETARY     DEFAULT=${selected_locale}
LC_PAPER        DEFAULT=${selected_locale}
LC_NAME DEFAULT=${selected_locale}
LC_ADDRESS      DEFAULT=${selected_locale}
LC_TELEPHONE    DEFAULT=${selected_locale}
LC_MEASUREMENT  DEFAULT=${selected_locale}
LC_IDENTIFICATION       DEFAULT=${selected_locale}
PAPERSIZE       DEFAULT=letter
EOF
				# set language in terminal to english
				grep -q -F 'export LANG=C' /home/"$USER"/.bashrc || echo -e "export LANG=C" | sudo tee -a /home/"$USER"/.bashrc >/dev/null

				# confirmation
				echo "Locale changed to $selected_locale"

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

				break
			else
				echo "Invalid option. Try again."
			fi
		done
		break
	else
		echo "Invalid option. Try again."
	fi
done
