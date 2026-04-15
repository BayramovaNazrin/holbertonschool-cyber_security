#!/bin/bash

failed=$(grep "Failed password" auth.log | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' | sort -u)
accepted=$(grep "Accepted" auth.log | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' | sort -u)

comm -12 <(echo "$failed") <(echo "$accepted") | wc -l
