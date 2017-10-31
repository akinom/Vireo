#!/bin/bash
cd "$(dirname "$0")"

git fetch --all 
git reset --hard  $1 
cp application.conf conf

./aws/git_report | mail -s "Vireo Reset" monikam@princeton.edu 

