#!/bin/bash
cat /dev/urandom | tr -cd '[:alnum:]' | head -c $1
