#!/bin/bash
sudo nmap -p 80, 22, 25, "$2" --reason "$1" 
