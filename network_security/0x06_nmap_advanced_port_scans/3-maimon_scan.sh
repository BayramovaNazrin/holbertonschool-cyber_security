#!/bin/bash
sudo nmap -sM -p 80, 443, 22, 21, 23 -v "$1"
