#!/bin/bash
cd "$(dirname "$0")"

rm -rf tmp/* 
./play/play stop 
git fetch  origin 
git merge --no-ff origin/test_configs
./play/play autotest

exit $?
