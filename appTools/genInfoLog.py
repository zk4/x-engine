#!/usr/bin/env python3

import os
import subprocess
bashCommand = "git log --pretty=format:%cn||%s||%cr"

process = subprocess.Popen(bashCommand.split(), stdout=subprocess.PIPE)
output, error = process.communicate()
lines = output.decode('utf-8').split("\n")
timestoEnds =7
for line in lines:
    [name,comment,elapsed] = line.split('||')
    matches = ["fix","feat","feature"]
    if any( comment.startswith(x) for x in matches) :
        print(name,comment,elapsed,'\\n')
    if comment.startswith("pgy"):
        timestoEnds-=1
        print('------last version------','\\n')
    if timestoEnds==0:
        break

    
