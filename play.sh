#!/bin/bash
CMD=$1
cd "$(dirname "$0")"
./play/play $CMD

exit $?
