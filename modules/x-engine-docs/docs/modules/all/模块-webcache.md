



1. 支持热发布也支持本地打包方式

2. 统一打开, 快速打开 (缓存)

3. 统一各环境发布方式 (在线)


## 打包

### 微应用

将 dist 文件夹打包为 zip 的形式

zip 包格式为  {microappid}.{version}.zip



> 为支持远程在线更新, 打包时注意, js,css,图片 文件如果有修改,则需要换用不同的 hash 名字.

- dist

  - css/
    - vendor.231d9nbds.css
  - index.html
  - microapp.json
  - sitemap.json

  

- com.zkty.microapp.mine.zip
  - css/
    - vendor.231d9nbds.css
  - index.html
  - microapp.json
  - sitemap.json



## 分发

![image-20210802132136901](https://zk4bucket.oss-cn-beijing.aliyuncs.com/img/image-20210802132136901.png)

### 原生集成上架分发

将 zip 解压到工程

com.gm.microapp.home

- index.html
- ...



### 在线分发

在线分发即按普通的 h5 发布.原生会做缓存以加快打开.见缓存章节.



### zip 包离线分发

zip 包更新是在线更新的一种补足方式. 对比版本.异步下载最新版.

<div style="page-break-after: always;"></div>

## 打开

一个是远程路由地址. 形如 http://  https:// 

一个是本地路由地址.  形如 file://  是由 microapp 转换而来

如果本地路由地址找不到, 需要经过路由转换为其他路由地址.  一般来说, 就是远程路由地址.



![image-20210802142533432](https://zk4bucket.oss-cn-beijing.aliyuncs.com/img/image-20210802142533432.png)



本地路由到远程路由的转换规则是什么?

两种: fallback, 与路由降级表

### fallback

fallback , 写在direct 参数里. fallback 为首页的完整字段.  {scheme}://{host}/{path}

示例 1: 

``` json
{
  scheme: "microapp",
  host: "com.gm.microapp.mine",
  pathname: "",
  fragment: "",
  params:{
	  __fallback__:'https://aaa.com/abc/index.html'
  }
}
```



那 microapp://com.gm.microapp.mine  找不到时会去找  https://aaa.com/abc/index.html

逻辑处理可以直接写 directManager 里. 如果没找到 container. 则重新调用 directManager.

>  注意: 不要出现死循环. 找不到->fallback->fallback ->fallback ...



### 路由降级表

fallback 参数是在路由的数据里. 

而路由降级表由原生端维护.是一个全局功能. 但提供的功能与 fallback 一样. 

可以维护一个map, schemeHostPath -> fallback

如 com.gm.microapp.mine ->  https://aaa.com/abc/index.html 的映射.



### 如何确认路由版本 version

*如果 params 里带了版本,则使用 params 里的版本, 如果 params 里没带版本. 则使用最高版本*

版本的概念只有 microapp , 也就是只有本地包有意义.

> 当前项目, 路由一般是不带版本. 所有初次打开时会找到最高版本. 
>
> 而在微应用内部的路由是复用了之前打开的信息. 所以也会找最高版本. 如果期间有离线包更新.也不会有影响.



## 缓存

下图描述了 iOS 与 android 的网络缓存. 

>  由于 iOS 在拦截请求时,会丢失 post body. 故需要在 xhr 层做拦截. 由 webview 注入 xhrhook.js.由原生请求.

![image-20210802214724985](https://zk4bucket.oss-cn-beijing.aliyuncs.com/img/image-20210802214724985.png)



 

### 缓存策略与实现

缓存分为两级. 最好直接找开源库. 这一块实现起来还是有点复杂. 

内存缓存,与磁盘缓存. 优先内存缓存.

![image-20210802140957160](https://zk4bucket.oss-cn-beijing.aliyuncs.com/img/image-20210802140957160.png)

实现细节:

1. 缓存空间不是无限大. 各端自行实现相关缓存移除策略, 如 LRU.
2. 注缓存的存取要是原子操作.
3. 内存与磁盘可以用 mmap 做映射.
4. 图片文件只缓存在磁盘, js,css 文件优先缓存在内存.





JSI Id: com.zkty.jsi.webcache

version: 2.8.1



## xhrRequest
[`async`](/docs/modules/模块-规范?id=jsi-调用)

**demo**
``` js

  //demo code

``` 

**无参数**

**无返回值**


    

