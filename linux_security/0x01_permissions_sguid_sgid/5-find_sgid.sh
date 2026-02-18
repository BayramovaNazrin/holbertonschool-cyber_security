#!/bin/bash
find "$1" -type f -perm -2000 -exec echo {} + 2>/dev/null
