#!/bin/bash
grep -Eo '^[0-9]{1,3}(\.[0-9]{1,3}){3}' logs.txt | sort | uniq | tail -1
