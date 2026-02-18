#!/bin/bash
john --format=NT --wordlist=/usr/share/wordlists/rockyou.txt "$1" && john --format=NT --show "$1" | cut -d: -f2 > 5-password.txt
