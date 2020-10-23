#!/Users/zk/anaconda3/bin/python3

from pathlib import Path
from os.path import join, isfile,basename,dirname
from pathlib import Path
from distutils.dir_util import copy_tree
import subprocess
import shutil
import os
import sys
import glob


tmplt = """

**基座扫描测试**
<div id='modulename' style='display:none'>{module_name}</div>
<img id='qrimg' src='https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=http://192.168.44.52:3000/docs/modules/all/dist/ui/index.html'></img>
<a id='qrlink' href="about:none">link of QR</a>

{root_readme}

# JS

{h5_readme}

# iOS
{ios_readme}

# android
{android_readme}

"""


class ReadmeAggregator():

    def __init__(self,path,outputDir):
        self.folder_path              = path
        self.module_short_name = self.folder_path.split("-")[-1]
        self.outputDir         = outputDir

    def locateReadme(self,folder_path,subpath):
        path = join(folder_path,subpath,"readme.md")
        path = path if os.path.isfile(path) else join(folder_path,subpath,"README.md")
        path = path if os.path.isfile(path) else join(folder_path,subpath,"Readme.md")
        path = path if os.path.isfile(path) else join(folder_path,subpath,"ReadMe.md")
        return path

    def readReadMe(self,path):
        if os.path.isfile(path):
            content = ""
            try:
                content = Path(path).read_text()
            except Exception as e:
                print(e)
            return  content
        return ""

    
    def gen_root(self):
        path = self.locateReadme(self.folder_path,".")
        self.cp_assets(path)
        return self.readReadMe(path)

    def gen_h5(self):
        path = self.locateReadme(self.folder_path,"h5")
        self.cp_assets(path)
        return self.readReadMe(path)

    def gen_iOS(self):
        path = self.locateReadme(self.folder_path,"iOS")
        self.cp_assets(path)
        return self.readReadMe(path)

    def gen_android(self):
        path = self.locateReadme(self.folder_path,"android")
        self.cp_assets(path)
        return self.readReadMe(path)
    
    def cp_assets(self,readmepath):
        assetsPath= join(dirname(readmepath),"assets")
        subprocess.Popen(["cp","-r",assetsPath,self.outputDir ]).communicate()
        # os.system(f"rsync -av --progress {assetsPath} {self.outputDir}")

    # def handle_img(self,path,out):
        # subprocess.Popen(["python3","/usr/local/bin/md_wash",path, "-c", "-u", "-o",out ]).communicate()
        # print("path",path,"out",out+"/assets/*",join(self.outputDir,"assets"))
        # subprocess.Popen(["cp","-r",out+"/assets/",join(self.outputDir,"assets/") ]).communicate()
    def gen_dist(self):
        os.system(f"pushd {self.folder_path}  &&  x-cli model model.ts && yarn md && popd && rm -rdf {self.outputDir}/dist/{self.get_short_module_name()} &&  cp -fr {self.folder_path}/h5/dist {self.outputDir}/dist/{self.get_short_module_name()}")

    def get_short_module_name(self):
        return self.module_short_name

    def output_path(self):
        return join(self.outputDir,"模块-"+self.module_short_name+".md")


    def gen(self):
        root_readme    = self.gen_root()
        h5_readme      = self.gen_h5()
        ios_readme     = self.gen_iOS()
        android_readme = self.gen_android()
        module_name    = self.get_short_module_name()
        self.gen_dist()

        content = tmplt.format(root_readme = root_readme,h5_readme = h5_readme, ios_readme = ios_readme, android_readme = android_readme, module_name=module_name)
        print(self.output_path())
        with open(self.output_path(),"w") as f:
            f.write(content)
        # gen _sidebar.md
        with open(join(self.outputDir,"_sidebar.md"),"a") as f:
            f.write(f"- [{self.module_short_name}](./docs/modules/all/模块-{self.module_short_name}.md)\n")
        # print(f'{self.module_short_name}')


if __name__ == "__main__":

    # shutil.rmtree("./docs/modules/all/assets")
    outputDir = "./docs/modules/all"
    with open(join(outputDir,"_sidebar.md"),"w") as f:
        f.write("")

    arr = os.listdir("..")
    exclude=['x-engine-module-offline','x-engine-module-protocols']
    include=['x-engine-module-router','x-engine-module-nav','x-engine-module-localstorage','x-engine-module-scan','x-engine-module-network','x-engine-module-camera','x-engine-module-dcloud']
    for d in arr:
        if d in include:
            # continue
        # if "x-engine-module" in d and "template" not in d and "protocols" not in d and "offline" not in d:
            path = "../"+d
            r = ReadmeAggregator(path,outputDir)
            r.gen()




