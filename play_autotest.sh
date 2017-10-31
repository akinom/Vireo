#!/bin/bash
cd "$(dirname "$0")"

rm -rf tmp/* 
./play/play stop 
./play/play autotest

exit $?
