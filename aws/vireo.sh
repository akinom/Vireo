#!/bin/bash

PLAY=$1
CMD=$2

cd "$(dirname "$0")"

if [ $CMD == "start" ] 
then 
   git fetch;
   git reset --hard origin/ec2
   cp ../application.conf ../conf
   git log --merges --author Mevenkamp | fgrep issue  | mail -s 'Vireo- issue list' monikam@princeton.edu
   git diff | mail -s 'Vireo-diff' monikam@princeton.edu
fi

cd ..
$PLAY $CMD

exit $?