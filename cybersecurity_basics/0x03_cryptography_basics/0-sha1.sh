#!/bin/bash
# This script hashes a password provided as an argument using SHA-1
echo -n "$1" | sha1sum | awk '{print $1}' > 0_hash.txt\\n\n
