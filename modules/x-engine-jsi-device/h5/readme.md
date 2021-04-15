

JSI Id: com.zkty.jsi.device

version: 0.1.13



## getStatusBarHeight
`sync`
> 获取状态栏高度
**demo**
``` js

  function test_getStatusHeight() {
    let val = xengine.api("com.zkty.jsi.device", "getStatusBarHeight");
    document.getElementById("debug_text").innerText = typeof val + ":" + val;
  }
``` 

**无参数**
**返回值**
``` js
string
``` 



## getNavigationHeight
`sync`
> 获取导航条高度

**无参数**
**返回值**
``` js
string
``` 



## getScreenHeight
`sync`
> 获取屏幕高度

**无参数**
**返回值**
``` js
string
``` 



## getTabbarHeight
`sync`
> 获取tabBar高度

**无参数**
**返回值**
``` js
string
``` 



## callPhone
`sync`
> 打电话

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


    