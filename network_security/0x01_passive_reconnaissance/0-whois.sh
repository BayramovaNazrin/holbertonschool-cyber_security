#!/bin/bash
whois "$1" | awk -F: '/^(Registrant|Admin|Tech)/ {v=substr($0, index($0, ":")+1); gsub(/\r/, "", v); gsub(/^[ \t]+/, "", v); v = " " v; if ($1 ~ /Ext/) $1 = $1 ":"; print $1 "," v}' > "${1}.csv"
