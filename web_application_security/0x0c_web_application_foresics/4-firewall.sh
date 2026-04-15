#!/usr/bin
grep -E "iptables|ufw" auth.log | grep -iE " -A | -I |allow|deny"
