## coge

coge 命令是用来根据已被管理的 git 文件快速生成模块。

```
pip3 install coge
```

在 x-engine-module-template 里运行 `coge -r` 生成模板源, 默认会将 x-engine-module-template 链接到  `~/.config/.code_template/x-engine-module-template`



如果你要生成 camera 的模块， 在 workspace 里运行。

```
coge x-engine-module-template xxxx:camera @:x-engine-module-camera -w
```



参数说明：

xxxx:camera                 x-engine-module-template 目录里所有的 xxxx  关键字替换成 camera。

@:x-engine-module-camera    生成的目标目录名叫 x-engine-module-camera

-w 	                     默认模板源必须是干净的 git 工程， -w 可忽略这一限制。 但如果你的文件未提交，使用了-w， 将不会出现在目标文件夹。 



