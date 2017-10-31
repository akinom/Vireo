#!/bin/bash
cd "$(dirname "$0")"

rm -rf tmp/* 
./play/play autotest

exit $?
