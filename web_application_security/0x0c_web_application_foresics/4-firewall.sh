#!/usr/bin
# 1. Grep for the firewall commands
# 2. Extract the part of the string after "allow " or "-dport "
# 3. Use 'sort -u' to find unique ports
# 4. Count them

grep -E "ufw|iptables" auth.log | \
    grep -iE "allow|ACCEPT" | \
    awk -F'allow |dport ' '{print $2}' | \
    awk '{print $1}' | \
    sed 's/\/.*//' | \
    sort -u | \
    wc -l
