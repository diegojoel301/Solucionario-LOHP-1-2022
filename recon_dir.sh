#!/bin/bash

host="192.168.146.139"

for fuzz in $(cat /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt); do
	for extension in $(cat extensiones); do
		state_code=$(curl -s -I http://192.168.146.139/$fuzz.$extension | tr -d '\r' | tr -d '\n' | awk '{print $2}')
		if [ $state_code != "404" ]; then
			echo "http://192.168.146.139/$fuzz.$extension"
		fi
	done
done
