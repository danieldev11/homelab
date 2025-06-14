#!/bin/bash

echo "Available connections: "
nmcli con show

read -p "Enter Connection Name: " connection
if [[ -z "$connection" ]] || ! nmcli con show "$connection" &>/dev/null; then
  echo "Invalid or missing connection name."
  exit 1
fi
read -p "Enter Static IP Address: " ip
if ! [[ "$ip" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+\/[0-9]+$ ]]; then
  echo "Invalid IP format. Expected: 192.168.50.101/24"
  exit 1
fi
read -p "Enter Gateway: " gateway
read -p "Enter DNS: " dns
read -p "Enter Hostname: " host

echo "[+] Setting static IP for $host"
nmcli con mod $connection \
	ipv4.addresses "$ip" \
	ipv4.gateway "$gateway" \
	ipv4.dns "$dns" \
	ipv4.method manual 

hostnamectl set-hostname $host


nmcli con down "$connection"
nmcli con up "$connection"

echo "[✓] Static IP $ip set and connection restarted."
