#!/bin/bash
function default() {
	echo "Use mapn.sh --all to scan current network for hosts"
	echo "Use mapn.sh --target=XX.XX.XX.XX to scan ports on the host with IP address XX.XX.XX.XX "
}
function all() {
	echo "List all hosts..."
	nmap -sL $(ip a sh eth0 | grep "inet " | cut -d " " -f 6)
}
function pscan() {
	echo "Portscanning host "
	#nmap -F $1
	nmap -F $1
}
nmap -v &> /dev/null
if  [ "$?" -ne 0 ]; then
	echo "Nmap is not installed. Installing..."
	sudo apt install nmap	
fi
if [ "$#" -eq 0 ]; then
	default
fi
if [ "$1" == "--all"  ]; then
	all
fi
if [[ $1 == "--target="* ]]; then
	addr=$(echo $1 | cut -d'=' -f 2)
	pscan $addr 
fi
#echo $1
