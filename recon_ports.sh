#!/bin/bash

# [+] 192.168.146.2
# [+] 192.168.146.139
# [+] 192.168.146.128

hosts=("192.168.146.2" "192.168.146.139" "192.168.146.128")

for host in ${hosts[@]}; do
	echo "[+] Host: $host"
	for puerto in $(seq 1 1000); do # 65535 puertos
		timeout 1 bash -c "</dev/tcp/$host/$puerto" &>/dev/null && echo -e "\t Puerto: $puerto"
	done
done
