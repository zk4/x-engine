#!/bin/bash

# 如果远程已删除,清除本地
git fetch -p origin

git branch -r --merged | grep -v develop | grep -v master | grep -v release  | sed 's/origin\///' | xargs -n 1 git push --delete origin
