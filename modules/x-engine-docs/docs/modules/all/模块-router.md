

**基座扫描测试**
<div id='modulename' style='display:none'>router</div>
<img id='qrimg' src='https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=http://192.168.44.52:3000/docs/modules/all/dist/ui/index.html'></img>
<a id='qrlink' href="about:none">link of QR</a>

统一所有的跳转, router 与 nav 在路由功能有一些重叠的地方. 但 nav 更加关注于微应用内的路由. 而 router 更关注应用间的路由.



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
   "url":"ZKPageViewController3,cn.timesneighborhood.app.c.view.activity.OpenGatesActivity",
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





|          | h5   | microApp | wx   | native | uni  |
| -------- | ---- | -------- | ---- | ------ | ---- |
| h5       | -    | -        | -    | -      | -    |
| microApp | 支持 | 支持     | 支持 | 支持   | 支持 |
| wx       | -    | -        | -    | -      | -    |
| native   | 支持 | 支持     | 支持 | 支持   | 支持 |
| uni      | -    | -        | -    | -      | -    |



[跳微信小程序需知](https://developers.weixin.qq.com/doc/oplatform/Mobile_App/Launching_a_Mini_Program/Launching_a_Mini_Program.html)

**跳转规则**

1. 对于已通过认证的开放平台账号，其移动应用可以跳转至任何合法的小程序，且不限制跳转的小程序数量。
2. 对于未通过认证的开放平台账号，其移动应用仅可以跳转至同一开放平台账号下小程序。

>  注意：若移动应用未上架，则最多只能跳转小程序100次/天，用于满足调试需求。



外部需求:

参看: [opensdk 接入指南](https://developers.weixin.qq.com/doc/oplatform/Mobile_App/Access_Guide/iOS.html)



# JS


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
      .openTargetRouter({ type: "h5", uri:"https://www.baidu.com", path:"" })
      .then((res) => { });
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| type | string |  | h5 | 跳转类型 |
| uri | string |  | https://www.baidu.com | 跳转目标 |
| path | string |  |  | 跳转参数 |

    

# iOS


# android


