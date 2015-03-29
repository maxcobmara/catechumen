#!/bin/bash -v
set -o verbose
git branch -a
git fetch origin production
git checkout production
ruby script/server -e production
