#!/bin/bash
grep -E "ufw|iptables" auth.log | \
    grep -iE "allow|ACCEPT" | \
    awk -F'allow |dport ' '{print $2}' | \
    awk '{print $1}' | \
    sed 's/\/.*//' | \
    sed 's/ssh/22/g' | \
    sort -u | \
    wc -l
