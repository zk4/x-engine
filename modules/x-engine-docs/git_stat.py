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

{root_readme}

# api

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
            content = Path(path).read_text()
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
    
    # def handle_img(self,path,out):
        # subprocess.Popen(["python3","/usr/local/bin/md_wash",path, "-c", "-u", "-o",out ]).communicate()
        # print("path",path,"out",out+"/assets/*",join(self.outputDir,"assets"))
        # subprocess.Popen(["cp","-r",out+"/assets/",join(self.outputDir,"assets/") ]).communicate()
    def cp_assets(self,readmepath):
        assetsPath= join(dirname(readmepath),"assets")
        subprocess.Popen(["cp","-r",assetsPath,self.outputDir ]).communicate()



    def get_short_module_name(self):
        return self.module_short_name

    def output_path(self):
        return join(self.outputDir,"模块-"+self.module_short_name+".md")


    def gen(self):
        root_readme    = self.gen_root()
        h5_readme      = self.gen_h5()
        ios_readme     = self.gen_iOS()
        android_readme = self.gen_android()

        content = tmplt.format(root_readme = root_readme,h5_readme = h5_readme, ios_readme = ios_readme, android_readme = android_readme)
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

    arr = os.listdir("..")
    for d in arr:
        # subprocess.Popen(["git-stats","--raw","|","git-stats-html",">>","/Users/zk/git/company/working/modules/x-engine-docs/out.html"])

        grepproc  = subprocess.Popen(["cd", f"../{d}" ,"git-stats","--raw"], stdout=subprocess.PIPE)
        pmrnaproc = subprocess.Popen(["git-stats-html"],stdin=grepproc.stdout)
        pmrnaproc.communicate()

 




