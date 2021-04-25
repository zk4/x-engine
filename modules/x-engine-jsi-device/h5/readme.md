

JSI Id: com.zkty.jsi.device

version: 0.1.13



## getStatusBarHeight
`sync`
> 获取状态栏高度
**demo**
``` js

  let val = xengine.api("com.zkty.jsi.device", "getStatusBarHeight");
  console.log(val);

``` 

**无参数**
**返回值**
``` js
string
``` 



## getNavigationHeight
`sync`
> 获取导航条高度
**demo**
``` js

  let val = xengine.api("com.zkty.jsi.device", "getNavigationHeight");
  console.log(val);

``` 

**无参数**
**返回值**
``` js
string
``` 



## getScreenHeight
`sync`
> 获取屏幕高度
**demo**
``` js

  let val = xengine.api("com.zkty.jsi.device", "getScreenHeight");
  console.log(val);

``` 

**无参数**
**返回值**
``` js
string
``` 



## getTabbarHeight
`sync`
> 获取tabBar高度
**demo**
``` js

  let val = xengine.api("com.zkty.jsi.device", "getTabbarHeight");
  console.log(val);

``` 

**无参数**
**返回值**
``` js
string
``` 



## callPhone
`sync`
> 打电话
**demo**
``` js

  xengine.api("com.zkty.jsi.device", "callPhone", {
    phoneNum: "18637369306",
    phoneMsg: "",
  });

``` 

**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| phoneNum | string | 必填 |  | 设备类型 |
| phoneMsg | string | 必填 |  | 设备版本 |
**返回值**
``` js
string
``` 



## sendMessage
`sync`
> 发短信
**demo**
``` js

  xengine.api("com.zkty.jsi.device", "sendMessage", {
    phoneNum: "18637369306",
    phoneMsg: "你好",
  });

``` 

**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| phoneNum | string | 必填 |  | 设备类型 |
| phoneMsg | string | 必填 |  | 设备版本 |
**返回值**
``` js
string
``` 



## getDeviceInfo
`async`
> 获取设备信息
**demo**
``` js

  xengine.api("com.zkty.jsi.device", "getDeviceInfo", {}, (val) => {
    console.log(JSON.stringify(val));
  });

``` 

**无参数**
**返回值**
``` js


// 设备模型
interface DeviceDTO {

  // 设备类型
  type: string;
  // 设备版本
  systemVersion: string;
  // 当前语言
  language: string;
  // 设备版本
  UUID: string;

}
``` 


    