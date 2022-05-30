#!/bin/bash

ip="192.168.146"

for i in $(seq 1 255); do
	timeout 1 bash -c "ping -c 1 $ip.$i" &>/dev/null && echo "[+] $ip.$i" &
done; wait
