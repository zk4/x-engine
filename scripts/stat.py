#!/usr/bin/env python3
import sys
def shouldIgnore(filename):
    ignoredExt=[".js",".ts",".a",".framework",".map",".zip"]
    ignoredFolders=["node_modules","/gen/","/dist/","/lib/","iOSUITests","/iOSTests/","main.m","AppDelegate","ZBarSDK","x-engine-module","UniBoost","ios-thirdlib","iOS 2","Lib",".framework","Chat"]
    for iext in ignoredExt:
        if filename.endswith(iext):
            return True
    for ifolder in ignoredFolders:
        if ifolder in filename:
            return True
    return False
if __name__ == "__main__":
    while True:
        try:
            line = input()
            if not shouldIgnore(line):
                print(line)
        except EOFError:
            # no more information
            break
