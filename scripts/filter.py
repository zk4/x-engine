#!/usr/bin/env python3
import sys

individualIgnores = {"Cwz-github": [".java"],
                     "MAJI": [".h",".m",".mm",".js",".vue",".ts"],
                     "Mr. Zhao": [".java"],
                     "Yang Bing Qiao": [],
                     "acewei": [],
                     "caopeng": [],
                     "dependabot[bot]": [],
                     "feitiecheng": [".h",".m",".mm",".js",".vue",".ts"],
                     "liuxiao00256": [".java"],
                     "lvdongjian": [".java"],
                     "wangsheng": [".java",".h",".m",".mm"],
                     "xiefei": [".h",".m",".mm",".js",".vue",".ts"],
                     "yangbingqiao": [],
                     "zeropercenthappy": [],
                     "zk": [".java"],
                     "zk4": [".java"],
                     "李宫": [".java"],
                     "ᒼʷᙆ": [".java"]}


def shouldIgnore(author,filename):
    ignoredExt = [".a", ".framework", ".map", ".zip", ".md"] + individualIgnores[author]
    ignoredFolders = ["node_modules", "/gen/", "/dist/", "/lib/", "iOSUITests", "/iOSTests/", "main.m", "AppDelegate", "ZBarSDK", "x-engine-module", "UniBoost", "ios-thirdlib", "iOS 2", "Lib", ".framework", "Chat", "/build/", "/docs",
                      '/test/', '/tests', 'example', 'com.gm.microapp', 'webpack', '/h5/src/', 'microApps', 'com.zkty.module', 'x-engine-hybrid', 'ZKTY_TZImagePickerController/', 'com.zkty.microapp', 'com.times.microapp', "androidTest", "x-engine-core","x-engine-app"]
    for iext in ignoredExt:
        if filename.endswith(iext):
            return True
    for ifolder in ignoredFolders:
        if ifolder in filename:
            return True
    return False


if __name__ == "__main__":
    name = sys.argv[1]
    print(name)
    while True:
        try:
            line = input()
            if not shouldIgnore(name,line):
                print(line)
        except EOFError:
            # no more information
            break
