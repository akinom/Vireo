#!/bin/bash
cd "$(dirname "$0")"

git fetch --all 
git co $1 
git reset --hard 
git pull 
cp application.conf conf

./aws/git_report | mail -s "Vireo Reset" monikam@princeton.edu 


