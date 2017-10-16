#!/bin/bash

PLAY=$1
CMD=$2

cd "$(dirname "$0")"

if [ $CMD == "start" ] 
then 
   git stash;
   git pull;
   git stash apply;
   git log --merges --author Mevenkamp | fgrep issue | mail -s 'Vireo- issue list' monikam@princeton.edu ldurgin@princeton.edu
fi 

cd ..
$PLAY $CMD

exit $?
