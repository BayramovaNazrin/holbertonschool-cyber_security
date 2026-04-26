#!/bin/bash

# Check if argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <target>"
    exit 1
fi

TARGET="$1"

# Run Nmap with default NSE scripts
sudo nmap -sC "$TARGET"
