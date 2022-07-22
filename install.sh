#!/bin/bash

clear

step0() {

read -r -p "
Hello! This script will install my dotfiles to your system under the current user.
Are you sure you want to continue? Answer with '1' or '2':

(1) Yes! I know what I'm doing and I'm aware this could break something.
(2) No thanks, I'll keep my stuff just as it is.

" ans0
	
	clear
	
	if [[ $ans0 = "1" ]]; then
		echo "Great! we'll get things started then."
		sleep 3; clear
	
	elif [[ $ans0 = "2" ]]; then
		echo "What are you doing running this then? ;)"
		sleep 3; clear && exit
	
	else
		echo "That option wasn't recognized, please use '1' or '2'..."
		sleep 3; clear
	fi

}	

step1(){

read -r -p "
It's usually a good idea to update your system before installing this. Would you like to do so?

(1) Yes, I'd like to update everything.
(2) No thanks, I know what I'm doing.

" ans1

	clear

	if [[ $ans1 = "1" ]]; then
		echo "sudo pacman -Syu"
		sleep 3; clear
	elif [[ $ans1 = "2" ]]; then
		echo "Alright, skipping..."
		sleep 3; clear
	else
			echo "That option wasn't recognized, please use '1' or '2'..."
		sleep 3; clear
	fi	
}

while [[ $ans0 != "1" ]] && [[ $ans0 != "2" ]]; do
	step0
done

while [[ $ans1 != "1" ]] && [[ $ans1 != "2" ]]; do
	step1
done
