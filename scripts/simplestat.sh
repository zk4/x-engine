#!/bin/bash

git log --author="$1" --pretty=tformat: --numstat | grep -EI '.*\.(h|m|java|mm|ts|js|vue)$' | filter.py 'zk'| less
