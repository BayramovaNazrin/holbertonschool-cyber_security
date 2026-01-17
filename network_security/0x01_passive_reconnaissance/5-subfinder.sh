#!/bin/bash
subfinder -d "$1" -silent -oI -o "$1.txt" > /dev/null 2>&1 && cut -d ',' -f 1 "$1.txt"
