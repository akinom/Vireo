#!/bin/bash
cd "$(dirname "$0")"

git fetch --all 
# clear out existing changes 
git reset --hard  
git reset --hard  $1 
cp application.conf conf


