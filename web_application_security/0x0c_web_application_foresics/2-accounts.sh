#!/bin/bash
tail -1000 auth.log | \
grep "session opened for user root" | \
tail -1 | \
awk '{print $11}'
