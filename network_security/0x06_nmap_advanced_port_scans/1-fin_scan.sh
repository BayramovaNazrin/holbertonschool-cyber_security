#!/bin/bash
sudo nmap -f -p 80-85 -sF -T2 "$1"
