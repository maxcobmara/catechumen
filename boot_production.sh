#!/bin/bash -v
set -o verbose
git checkout master
git pull origin master
git branch -a
git fetch origin production
git checkout production
git pull origin production
ruby script/server -p 3000 -e production
