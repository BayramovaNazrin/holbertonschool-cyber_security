#!/bin/bash
grep "Invalid user" auth.log | awk '{print $10}' | sort | uniq | wc -l
