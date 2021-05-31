#!/bin/bash
git branch --merged develop | grep -v "\* develop" | xargs -n 1 git branch -d
