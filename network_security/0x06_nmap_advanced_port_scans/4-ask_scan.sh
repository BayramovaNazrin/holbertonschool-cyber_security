#!/bin/bash
sudo nmap -sA -p 80, 22, 25, "$2" --reason "$1" 
