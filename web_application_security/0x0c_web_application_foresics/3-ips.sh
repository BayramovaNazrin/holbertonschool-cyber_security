#!/bin/bash
grep "Invalid user" | awk '{print $10}' | sort | uniq | wc -l
