

**基座扫描测试**
<div id='modulename' style='display:none'>offline</div>
<img id='qrimg' src='https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=http://192.168.44.52:3000/docs/modules/all/dist/ui/index.html'></img>
<a id='qrlink' href="about:none">link of QR</a>


此模块用于离线更新, 自动触发.

## 客户端更新流程

 - 启动
   - 请求服务器获取 microApp.json
     - 请求成功:
       - 循环:url,version = locateMicroAppByMicroappId
         - url != nil: 通过 appid 对比版本号
           - 本地版本低, 下载远程新版本,并解压到沙盒
           - 本地版本一样或更高, 返回
         - url 为 nil: 下载远程新版本,并解压到沙盒
     - 请求失败: 不做任何事



 - (url) locateMicroAppByMicroappId(&version)
   - 从沙盒找
     - 成功, 返回 index.html 位置与版本
     - 失败, 从工程找
       - 成功 返回 index.html 位置与版本
       - 失败 返回 (nil,-1)



## 微应用存储的位置

各平台表现不一, 假设可持久化存储位置为 X

```
{X}/microApps/{microAppId}.{version}/index.html

{X}/microApps/{microAppId}.{version}/icon.png

{X}/microApps/{microAppId}.{version}/...
```



microApps 做为一个统一的 microApp 入口.

```
- {X}
	- microApps
		-	com.zkty.xiaoqu.opendoor.1
				- index.html
				- icon.png
		- com.zkty.xiaoqu.opendoor.2
				- index.html
				- icon.png
		-	com.zkty.xiaoqu.shequ.1
				- index.html
				- icon.png
```







## zip 包格式

```
- {microAppId}.{version}.zip
  - index.html
  - icon.png   // 128*128
  - ...
```

举例:

``` json
- com.zkty.xiaoqu.opendoor.1.zip
  - index.html
  - icon.png
	- ...
```



## 引擎应用配置

xengine_config.json:

``` json
{
  "appId": "com.zkty.xiaoqu",    // 建议直接设置为应用的 Bundle Identifier
  "appSecret": "8b387ca3ebdd412e9c97ef81ed352ee7",  //随机 md5 值.
  "offlineServerUrl": "https://3rd-public-file.oss-cn-beijing.aliyuncs.com"  //服务器地址,
  ...
}
```

 

## app 微应用集合地址

请求地址:

```
GET: {offlineServerUrl}/app/{appId}/microApps.json?key=md5(appSecret+appId)
```



```
key 由  md5 算出. 
key = md5(appSecret+appId)
```

返回: 有新版本

```
http status: 200
```

microApps.json:

``` json
{
  "code":0,
  "version":3,     // microApps.json 版本标识
  "forceUpdate" true,  // 是否强制更新
  "data":
        [
          {
            "microAppName":"开门",
            "microAppId":"com.zkty.xiaoqu.opendoor",
            "microAppVersion":2
          },
          {
            "microAppName":"物业",
            "microAppId":"com.zkty.xiaoqu.realstate"
            "microAppVersion":1
          }
        ]
  }
```



没新版本:

http status: 200

``` json
{
  "code":304,
  "version":1,
 
  }
```

 

> microApps.json 应该持久化在手机应用本地. 用来对比. 
>
> 如果不持久化到本地, 那就需要扫描本地 microApps 来对比是否需要更新版本.



打开微应用

```
xEngine.showMicroApp({microAppId},{version},{args},{microAppName})
```



## 微应用 zip 下载地址

```
GET: {offlineServerUrl}/app/{appId}/{microAppId}.{version}.zip?key=md5(appSecret+microAppId+version)&engine_build=1

```

返回: zip 包

示例:

http://192.168.3.129:8000/app/com.zkty.xiaoqu/com.zkty.xiaoqu.opendoor.1.zip?key=1f2414c23a7d55dddc11caa32a8e9a4a&engine_build=1

 

engine_build 为引擎 build 号. 由引擎 sdk 暴露获取方法. engine_build 为一个数字.





# JS



# iOS


# android


