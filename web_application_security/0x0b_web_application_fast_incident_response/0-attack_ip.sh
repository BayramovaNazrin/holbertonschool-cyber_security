#!/bin/bash
rep -Eo '^[0-9]{1,3}(\.[0-9]{1,3}){3}' logs.txt | sort | uniq -c
rep -Eo '^[0-9]{1,3}(\.[0-9]{1,3}){3}' logs.txt | sort | uniq -c | tail -1
