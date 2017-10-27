#!/bin/bash

PLAY=$1
CMD=$2

cd "$(dirname "$0")"
if [ $CMD == "start" ] 
then 
   git fetch;
   git reset --hard origin/ec2
   cp ../application.conf ../conf
   ./git_report | mail -s "Vireu Status $HOST" monikam@princeton.edu 
fi

cd ..
$PLAY $CMD

exit $?

