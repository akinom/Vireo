#!/bin/bash
cd "$(dirname "$0")"

rm -rf tmp/* 
./play/play stop 
git reset --hard 
git pull origin test_configs
git merge test_configs
./play/play autotest

exit $?
