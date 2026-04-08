#!/bin/bash
awk -F\" '/54.145.34.34/ {print $6}' logs.txt | sort |  uniq -c | sort -nr |head -1 |  awk '{print $2}'
