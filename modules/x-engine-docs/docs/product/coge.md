## coge

coge 命令是用来根据已被管理的 git 仓库快速生成自己的代码。 

原理很简单，就是想办法一定替换你想替换的字符串。不管这个字符串是文件夹还是文件名，还是文件内容。

比如如下文件夹

- xxxx1
  - Xxxx
    - abc.txt // 里面包含 xxxx yyyy 字段

在 xxxx1 文件 执行

```
coge -r 
```

生成模板源，默认会在 ~/.code_template 里生成。 你可以执行  `coge` 查看所有模板命令。

在你想生成文件的路路径，比如 ~/demo ，执行

```
coge xxxx1  xxxx:abc yyyy:zzzz  @:hello -w
```



就会在 ~/demo/ 下生成

- abc1
  - Abc
      - abc.txt // 里面 xxxx 替换为了 abc 字段 里面 yyyy 替换为了 zzzz 字段








市面上同类的的有 yo， hygen。 但不是慢就是基于非原生语言模板，用起来非常费劲。得用很多精力去维护模板。模板还不能直接运行。不能实时修改。

当然， 同类的一个优势在于，它能基于选择去生成代码。但我觉得这是你工程层面模块化要解决的一件事。而不是基于模板化。

vue-cli 也算是一种模板生成工具，做的重且只能生成 vue 项目。

比如我就想快速生成一个 vue 项目，用 vue-cli 会让你选择要不要 vue-router， 要不要 babel 等。 然后选完后，自动执行 npm install。然后还有一个贴心功能，“保存为默认选项”。 挺好

但随着 vue 的升级。 你会发现 vue-cli 同样的命令，告诉你生成项目出错。。 比如

![image-20210830002504319](https://zk4bucket.oss-cn-beijing.aliyuncs.com/img/image-20210830002504319.png)

当然解决方法很容易查到。 但一个模板生成工具为什么不能时刻按我原来设想的模板快速生成？



而基于 coge，不会有这样的问题， 你可以事先拿 vue-cli 生成一个模板源。这个模板源可以在任何位置。甚至可以是 github 里的一个仓库。具体实例参看下面生成 vue-hello



coge 当然不是要取代 vue-cli， 或任何其他模板生成工具。 只是它更纯粹只做模板的事。

coge 与框架与语言没任何关系。你可以用 coge 管理你想管理的任何模板。





## 安装

```
pip3 install coge
```



## 使用

在你模板源里执行 coge -r 

比如我们用 vue-ci 生成一个干净的项目。



## 生成 vue-hello 

我假定你已经有一个可运行的 vue 干净项目。叫 vue-template, 并通过 git 管理。


![image-20210830003337836](https://zk4bucket.oss-cn-beijing.aliyuncs.com/img/image-20210830003337836.png)

一般来讲，我们生成项目时，会希望同时修改 package.json 的 name， author。 给它们取一个一定不会重复的名字

```
// package.json
{
  "name": "coge_name",
  "author": "coge_author",
  ...
}
```
提交一下
````
git commit 
````



执行 

```
coge -r 
```

会将当前文件链到 ~/.code_template 

![image-20210830003843593](https://zk4bucket.oss-cn-beijing.aliyuncs.com/img/image-20210830003843593.png)



以后，但凡你需要起一个 vue 项目。

```
coge vue_template coge_name:vue_mall   coge_author:zk @:vue_mall -w
```

![image-20210830004055995](https://zk4bucket.oss-cn-beijing.aliyuncs.com/img/image-20210830004055995.png)



大概 0.001 秒， 完事。

```
yarn 
yarn serve
```



如果你想连 yarn 都不想做， 直接想 yarn serve， 也可以，提交模板源里的 node_modules 。

我们将模板生成到 vue_mall2 运行命令

```
coge vue_template coge_name:vue_mall   coge_author:zk @:vue_mall2 -w
```

在我电脑上，大概用了 15 秒左右。直接在文件夹里运行 yarn serve

```
yarn serve
```

![image-20210830013747408](https://zk4bucket.oss-cn-beijing.aliyuncs.com/img/image-20210830013747408.png)



## 生成 x-engine 模块（demo）

在 x-engine-module-template 里运行 `coge -r` 生成模板源, 默认会将 x-engine-module-template 链接到  `~/.config/.code_template/x-engine-module-template`



如果你要生成 camera 的模块， 在 workspace 里运行。

```
coge x-engine-module-template xxxx:camera @:x-engine-module-camera -w
```



参数说明：

xxxx:camera                 x-engine-module-template 目录里所有的 xxxx  关键字替换成 camera。

@:x-engine-module-camera    生成的目标目录名叫 x-engine-module-camera

-w 	                     默认模板源必须是干净的 git 工程， -w 可忽略这一限制。 但如果你的文件未提交，使用了-w， 将不会出现在目标文件夹。 



