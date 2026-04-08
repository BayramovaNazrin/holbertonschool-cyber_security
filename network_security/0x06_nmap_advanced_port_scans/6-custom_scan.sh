#!/bin/bash
sudo nmap --scanflags URGACKPSHRSTSYNFIN "$1" -p "$2" -oN "URGACKPSHRSTSYNFIN" 2>/div/null
