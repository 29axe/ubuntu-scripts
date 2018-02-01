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
