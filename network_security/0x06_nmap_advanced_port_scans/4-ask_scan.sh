#!/bin/bash
sudo nmap -sA -host-timeout 1000 -p 80, 22, 25, "$2" --reason "$1" 
