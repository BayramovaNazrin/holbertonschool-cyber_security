#!/bin/bash
grep "Accepted" auth.log | grep -Eo 'from ([0-9]{1,3}\.){3}[0-9]{1,3}' | awk '{print $2}' | sort -u | wc -l
