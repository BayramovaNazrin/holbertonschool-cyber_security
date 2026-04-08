#!/bin/bash
sudo nmap -sX -p 440-450 --reason --packet-trace --open "$1"
