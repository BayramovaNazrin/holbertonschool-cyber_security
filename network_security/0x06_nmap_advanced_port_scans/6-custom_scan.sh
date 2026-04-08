#!/bin/bash
sudo nmap --scanflags URGACKPSHRSTSYNFIN "$1" -p "$2" -oN "custom_scan.txt" 2>/dev/null
