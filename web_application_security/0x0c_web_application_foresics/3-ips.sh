#!/bin/bash
grep "Accepted" auth.log \
| grep -Eo 'from ([0-9]{1,3}\.){3}[0-9]{1,3}' \
| awk '{print $2}' \
| grep -Ev '^(10\.|192\.168\.|172\.(1[6-9]|2[0-9]|3[0-1])\.)' \
| sort -u \
| wc -l
