#!/bin/bash

PLAY=$1
CMD=$2

cd "$(dirname "$0")"

git stash;
git pull;
git stash apply;

cd ..
$PLAY $CMD

exit $?
