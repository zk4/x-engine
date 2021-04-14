

JSI Id: com.zkty.jsi.device

version: 0.1.13



## getStatusBarHeight

 获取状态栏高度

**demo**

	
**无参数**




---------------------
**无返回值**




## getNavigationHeight

 获取导航条高度

**demo**

	
**无参数**




---------------------
**无返回值**




## getScreenHeight

 获取屏幕高度

**demo**

	
**无参数**




---------------------
**无返回值**




## getTabbarHeight

 获取tabBar高度

**demo**

	
**无参数**




---------------------
**无返回值**




## getSystemVersion

 获取系统版本

**demo**

	
**无参数**




---------------------
**无返回值**




## getUUID

 获取iOS设备的UUID

**demo**

	
**无参数**




---------------------
**无返回值**




## callPhone

 打电话

**demo**

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| phoneNum | string | 必填 |  |  设备类型 |
| phoneMsg | string | 必填 |  |  设备版本 |


---------------------
**无返回值**




## sendMessage

 发短信

**demo**

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| phoneNum | string | 必填 |  |  设备类型 |
| phoneMsg | string | 必填 |  |  设备版本 |


---------------------
**无返回值**




## getDeviceInfo

 获取设备信息

**demo**

	
**无参数**




---------------------
**无返回值**




## getDeviceInfo1

 获取设备信息

**demo**

	
**无参数**




---------------------
**返回值**
``` js

interface DeviceDTO {

  // 设备类型
  type: string;
  // 设备版本
  systemVersion: string;
  // 设备类型
  language: string;
  // 设备版本
  UUID: string;

}
``` 




## text_getScreenHeight



**demo**
``` js

  let val = xengine.api("com.zkty.jsi.device", "getScreenHeight");
  document.getElementById("debug_text").innerText = typeof val + ":" + val;

``` 

	
**无参数**




---------------------
**无返回值**




## text_getTabbarHeight



**demo**
``` js

  let val = xengine.api("com.zkty.jsi.device", "getTabbarHeight");
  document.getElementById("debug_text").innerText = typeof val + ":" + val;

``` 

	
**无参数**




---------------------
**无返回值**




## text_callPhone



**demo**
``` js

  xengine.api("com.zkty.jsi.device", "callPhone", {
    phoneNum: "18637369306",
    phoneMsg: ''
  });

``` 

	
**无参数**




---------------------
**无返回值**




## text_sendMsg



**demo**
``` js

  xengine.api("com.zkty.jsi.device", "sendMessage", {
    phoneNum: "18637369306",
    phoneMsg: '你好'
  });

``` 

	
**无参数**




---------------------
**无返回值**




## text_getDeviceInfo



**demo**
``` js

  let val = xengine.api("com.zkty.jsi.device", "getDeviceInfo");
  document.getElementById("debug_text").innerText = typeof val + ":" + val;

``` 

	
**无参数**




---------------------
**无返回值**




## text_getDeviceInfo1



**demo**
``` js

  xengine.api("com.zkty.jsi.device", "getDeviceInfo1", {}, (val) => {
   document.getElementById("debug_text").innerText = typeof val + ":" + val;
  });

``` 

	
**无参数**




---------------------
**无返回值**



    