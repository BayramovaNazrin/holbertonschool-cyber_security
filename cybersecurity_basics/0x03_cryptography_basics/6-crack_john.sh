#!/bin/bash
john --format=Raw-SHA256 "$1" && john --format=Raw-SHA256 --show "$1" | cut -d: -f2 > 6-password.txt
