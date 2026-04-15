#!/bin/bash
tail -1000 auth.log | grep -E "Failed password|Accepted password"
