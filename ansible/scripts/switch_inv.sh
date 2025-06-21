#!/bin/bash

if [ "$1" = "home" ]; then
	ln -sf /home/user/homelab/ansible/inventories/static.ini /home/user/homelab/ansible/inventory.ini
elif [ "$1" = "cafe" ]; then
	ln -sf /home/user/homelab/ansible/inventories/dynamic.ini /home/user/homelab/ansible/inventory.ini
else
	echo "Invalid, use 'home' or 'cafe'."
fi 	
