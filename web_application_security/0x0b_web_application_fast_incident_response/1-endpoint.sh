#!/bin/bash
grep -E '"(GET|PUT|DELETE|HEAD|POST)' logs.txt| awk -F\" '{print $2}' | awk '{print $2}' | sort | uniq -c | sort -nr | head -1 | awk '{print $2}' 
