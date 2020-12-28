#!/usr/bin/env python3

import os
import subprocess
bashCommand = "git log --pretty=format:%cn||%s||%cr"

process = subprocess.Popen(bashCommand.split(), stdout=subprocess.PIPE)
output, error = process.communicate()
lines = output.decode('utf-8').split("\n")
timestoEnds =3
for line in lines:
    [name,comment,elapsed] = line.split('||')
    matches = ["fix","feat","feature"]
    if any(x in comment for x in matches) :
        print(name,comment,elapsed,'\\n')
    if comment.startswith("pgy"):
        timestoEnds-=1
    if timestoEnds==0:
        break
