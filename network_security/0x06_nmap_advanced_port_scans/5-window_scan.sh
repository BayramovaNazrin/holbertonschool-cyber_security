#!/bin/bash
sudo nmap -sW -p "$2", 20-30 --exclude-ports "$3", 25-28 "$1"  
