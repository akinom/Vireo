#!/bin/bash
CMD=$1
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_144.jdk/Contents/Home
cd "$(dirname "$0")"
./play/play $CMD

exit $?
