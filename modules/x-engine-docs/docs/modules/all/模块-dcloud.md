

**基座扫描测试**
<div id='modulename' style='display:none'>dcloud</div> <img id='qrimg' src='https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=http://192.168.44.52:3000/docs/modules/all/dist/ui/index.html'></img>
<a id='qrlink' href="about:none">link of QR</a>




# JS


version: 0.0.58
``` bash
npm install @zkty-team/x-engine-module-dcloud
```



## openUniMP

 启动小程序

**demo**
``` js
{
  window.openUniMP = () => {
    dcloud.openUniMP().then((res) => {
      document.getElementById("debug_text").innerText = "ret:"+res;
    });
 };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| appId | string |  | __UNI__11E9B73 | 小程序appId |


## preloadUniMP

 预加载后打开小程序

**demo**
``` js
{
  window.preloadUniMP = () => {
    dcloud.preloadUniMP().then((res) => {
      document.getElementById("debug_text").innerText = "ret:"+res;
    });
 };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| appId | string |  | __UNI__9B75743 |  |
| arguments | Map\<string,string\> |  | {"token":"this is token","refreshtoken":"this is refreshtoken"} | 配置启动小程序时传递的参数 |
| redirectPath | string |  | pages/component/application/application?token=a&refreshtoken=b |  路径 |
| enableBackground | bool |  |  |  开启后台运行 |
| showAnimated | bool | true |  | 是否开启 show 小程序时的动画效果 默认：true |
| hideAnimated | bool | true |  | 是否开启 hide 时的动画效果 默认：true |


## openUniMPWithArg



**demo**
``` js
{
  window.openUniMPWithArg = () => {
    dcloud.openUniMPWithArg().then((res) => {
      document.getElementById("debug_text").innerText = "ret:"+res;
    });
 };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| appId | string |  | __UNI__9B75743 |  |
| arguments | Map\<string,string\> |  | {"token":"this is token","refreshtoken":"this is refreshtoken"} | 配置启动小程序时传递的参数 |
| redirectPath | string |  | pages/component/application/application?token=a&refreshtoken=b |  路径 |
| enableBackground | bool |  |  |  开启后台运行 |
| showAnimated | bool | true |  | 是否开启 show 小程序时的动画效果 默认：true |
| hideAnimated | bool | true |  | 是否开启 hide 时的动画效果 默认：true |

    

# iOS


# android


