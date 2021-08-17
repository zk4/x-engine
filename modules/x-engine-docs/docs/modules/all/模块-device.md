





JSI Id: com.zkty.jsi.device

version: 2.8.1



## getStatusBarHeight
[`sync`](/docs/modules/模块-规范?id=jsi-调用)
> 获取状态栏高度<br>单位 （android : dp ； ios: pt ； 对应h5: 逻辑像素 px）
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
[`sync`](/docs/modules/模块-规范?id=jsi-调用)
> 获取导航条高度<br>单位 （android : dp ； ios: pt ； 对应h5: 逻辑像素 px）
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
[`sync`](/docs/modules/模块-规范?id=jsi-调用)
> 获取屏幕高度<br>单位 （android : dp ； ios: pt ； 对应h5: 逻辑像素 px）
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
[`sync`](/docs/modules/模块-规范?id=jsi-调用)
> 获取tabBar高度<br>单位 （android : dp ； ios: pt ； 对应h5: 逻辑像素 px）
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
[`sync`](/docs/modules/模块-规范?id=jsi-调用)
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
[`sync`](/docs/modules/模块-规范?id=jsi-调用)
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
[`async`](/docs/modules/模块-规范?id=jsi-调用)
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


    

