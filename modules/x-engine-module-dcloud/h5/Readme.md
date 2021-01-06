
version: 0.1.7
``` bash
npm install @zkty-team/x-engine-module-dcloud
```



## openUniMP

 启动小程序

**demo**
``` js
{
  window.openUniMP = () => {
    dcloud.openUniMP({
    appId:'__UNI__9B75743'
  }).then((res) => {
      document.getElementById("debug_text").innerText = "ret:"+res;
    });
 };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| appId | string | 必填 |  | 小程序appId |

**返回值**
**无参数**




## preloadUniMP

 预加载后打开小程序

**demo**
``` js
{
  window.preloadUniMP = (
    
  ) => {
    dcloud.preloadUniMP({
    appId:'__UNI__11E9B73',
    arguments:{'token':'this is token','refreshtoken':'this is refreshtoken'},
    redirectPath:'pages/component/application/application?token=a&refreshtoken=b',
    enableBackground:false,
  }).then((res) => {
      document.getElementById("debug_text").innerText = "ret:"+res;
    });
 };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| appId | string | 必填 |  |  |
| arguments | Map\<string,string\> | 必填 |  | 配置启动小程序时传递的参数 |
| redirectPath | string | 必填 |  |  路径 |
| enableBackground | bool | 必填 |  |  开启后台运行 |
| showAnimated | bool | optional |  | 是否开启 show 小程序时的动画效果 默认：true |
| hideAnimated | bool | optional |  | 是否开启 hide 时的动画效果 默认：true |

**返回值**
**无参数**




## openUniMPWithArg



**demo**
``` js
{
  window.openUniMPWithArg = () => {
    dcloud.openUniMPWithArg({
    appId:'__UNI__9B75743',
    arguments:{'token':'this is token','refreshtoken':'this is refreshtoken'},
    redirectPath:'pages/component/application/application?token=a&refreshtoken=b',
    enableBackground:false,
  }).then((res) => {
      document.getElementById("debug_text").innerText = "ret:"+res;
    });
 };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| appId | string | 必填 |  |  |
| arguments | Map\<string,string\> | 必填 |  | 配置启动小程序时传递的参数 |
| redirectPath | string | 必填 |  |  路径 |
| enableBackground | bool | 必填 |  |  开启后台运行 |
| showAnimated | bool | optional |  | 是否开启 show 小程序时的动画效果 默认：true |
| hideAnimated | bool | optional |  | 是否开启 hide 时的动画效果 默认：true |

**返回值**
**无参数**



    