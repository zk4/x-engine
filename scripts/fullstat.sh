#!/bin/bash
git log --format='%aN' | sort -u | while read name; do echo -en "$name\t"; git log --author="$name" --pretty=tformat: --numstat | grep  -EI '.*\.(h|m|java|mm|ts|js|vue)$' | filter.py $name | awk '{ add += $1; subs += $2; loc += $1 - $2 } END { printf "+: %s, -: %s, =: %s\n", add, subs, loc }' -; done
