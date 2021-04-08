

**基座扫描测试**
<div id='modulename' style='display:none'>router</div> <img id='qrimg' src='https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=http://192.168.44.52:3000/docs/modules/all/dist/ui/index.html'></img>
<a id='qrlink' href="about:none">link of QR</a>

统一所有的跳转, router 与 nav 在路由名称上有所混淆. nav 只用在微应用内部, router 是用于全局路由. 包含了 nav 的功能.

但 router 一定会创建新实例. 如果只在某微应用内部路由.应该只使用nav.一来性能好,二来你能拥有一个统一的状态管理器. 比如 vue 里的 vuex. react 里的 redux. 



##### 规则

- 跳 h5
  - https://..
  - http://..
- 跳微应用
  - appid + 路径 + 参数
- 跳 uniapp
  - appid + 路径 + 参数
- 跳 [微信小程序](https://developers.weixin.qq.com/doc/oplatform/Mobile_App/Launching_a_Mini_Program/iOS_Development_example.html)
  - userName + 路径 + 参数
- 跳原生界面
  - iOS
    - 类名 + 参数
  - android
    - 类名 + 参数

![image-20201010170737644](assets/image-20201010170737644.png)

参数:

````
{
  type: string (native | h5 | microapp | uni | wx ),  // string 类型 maxlength(16)
  uri:  string (url | microappid | wx_username | 'XViewController,com.zkty.view.XActivity'), // 资源名 maxlength(1024)
  fallback: string,         //(url链接)，maxlength(1024)
  path: string,             // 路径 /abc  /abc?a=1  maxlength(4096)　注意：参数在这传递！
 	version: int,             // 如果是 microapp, version 代表版本号，
	hideNavbar: boolean,      // 路由目标页是否显示 navbar,默认是 false
　args: map                 // 保留字段，　
}
````



args　形如：

```
{
	"something":"",
	...
}
```



比如金刚区：

``` json
[
 {
   "type": "microapp",
   "uri": "com.zkty.microapp.propertylist",
   "path": "/", 
   "fallback": "http//:www.baidu.com",
   "version":0,
   "args": {}
 },
 {
   "type": "h5",
   "uri": "https://www.baidu.com",
   "fallback": "http//:www.baidu.com",
   "path": "/"
 },
 {
   "type": "uni",
   "uri": "__UNI__86C4327",
   "fallback": "http//:www.baidu.com",
   "path": "/"
 },
 {
   "type":"native",
   "url":"ZKLocalWebViewController,cn.timesneighborhood.app.c.view.activity.OpenGatesActivity",
   "fallback": "http//:www.baidu.com",   
 },
 {
   "type":"wx",
   "uri":"wx_dfsnosj28123"，
   "path":"/home",
   "fallback": "http//:www.baidu.com"
 }
]
```





|             | h5     | microApp | wx     | native | uni    |
| ----------- | ------ | -------- | ------ | ------ | ------ |
| h5 跳       | 无意义 | 支持     | 支持   | 支持   | 支持   |
| microApp 跳 | 支持   | 无意义   | 支持   | 支持   | 支持   |
| wx 跳       | -      | -        | 无意义 | -      | -      |
| native 跳   | 支持   | 支持     | 支持   | 无意义 | 支持   |
| uni 跳      | 支持   | 支持     | 支持   | 支持   | 无意义 |



**h5通过 scheme 的方式**

x-engine-call://{moduleId}/{method}?args={xxx}&callback={callbackurl}

```
window.open(`x-engine-call://${moduleId}/${method}/args=${encodeURIComponent({...})&callback=encodeURIComponent("https://xxx.com/indexhtml?ret={ret}")}`)
```



xxx 为 urlencode 过的　json　**String** (使用 encodeURIComponent)
{callbackurl} 由调用者指定(必须urlencode), 如[https://baidu.com?ret={ret}](https://baidu.com/?ret={ret})

{ret} 将被替换为返回值. {ret} 为 urlencode 过的　json　**String**

在拿到返回值后, 在当前页面打开 {callbackurl}





**uni 通过 api 方式**



event:x-engine-wgt-call

{
"moduleId":"moduleId",
"method":{method},
"args":{args},
}

返回值, 统一转成 json string.





> 将弃用
>
> event:x-engine-wgt-event
>
> {
> "moduleName":"moduleName",
> "method":{method},
> "args":{args},
> }
>
> 返回值, 统一转成 json string.





[跳微信小程序需知](https://developers.weixin.qq.com/doc/oplatform/Mobile_App/Launching_a_Mini_Program/Launching_a_Mini_Program.html)

**跳转规则**

1. 对于已通过认证的开放平台账号，其移动应用可以跳转至任何合法的小程序，且不限制跳转的小程序数量。
2. 对于未通过认证的开放平台账号，其移动应用仅可以跳转至同一开放平台账号下小程序。

>  注意：若移动应用未上架，则最多只能跳转小程序100次/天，用于满足调试需求。



外部需求:

参看: [opensdk 接入指南](https://developers.weixin.qq.com/doc/oplatform/Mobile_App/Access_Guide/iOS.html)



# JS

version: 0.1.12
``` bash
npm install @zkty-team/x-engine-module-router
```



## openTargetRouter

跳转页面.

**demo**
``` js
 {
  window.openTargetRouter = () => {
    router
      .openTargetRouter({ type: "h5", uri:"http://192.168.10.51:8081/index.html", path:"" })
      .then((res) => { });
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| type | string | 必填 | h5 | 跳转类型 |
| uri | string | 必填 | http://192.168.10.51:8081/index.html | 跳转目标 |
| path | string | 必填 |  | 跳转参数 |
| args | Map\<string,string\> | optional |  | 其他参数 |
| version | int | optional |  |  |
| hideNavbar | bool | optional |  |  是否隐藏navbar, 默认 false |


参数 object  定义
``` js


interface RouterOpenAppDTO {

  //跳转类型
  type: string;
  //跳转目标
  uri: string;
  //跳转参数
  path: string;
  //其他参数
  args?:Map<string,
 string>;

  version?: int;

  // 是否隐藏navbar,
 默认 false
  hideNavbar?: boolean;

}
``` 


---------------------
**无返回值**



    

# iOS


# android


