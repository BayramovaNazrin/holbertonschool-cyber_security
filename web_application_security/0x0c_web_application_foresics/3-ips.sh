#!/bin/bash
grep -Eo '^[0-9]{1,3}(\.[0-9]{1,3}){3}' "$1" | sort -u | wc -l 
