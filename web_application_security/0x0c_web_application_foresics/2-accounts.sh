#!/bin/bash
grep "session opened for user root" auth.log | tail -1
