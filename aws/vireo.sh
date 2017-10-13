#!/bin/bash

PLAY=$1
CMD=$2

cd "$(dirname "$0")"

if [ $CMD == "start" ] 
then 
   git stash;
   git pull;
   git stash apply;
fi 

cd ..
$PLAY $CMD

exit $?
