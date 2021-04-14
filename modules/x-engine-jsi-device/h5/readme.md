

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




## getUDID

 获取iOS设备的UDID

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


// 设备模型
interface DeviceDTO {

  // 设备类型
  type: string;
  // 设备版本
  systemVersion: string;
  // 设备类型
  language: string;
  // 设备号
  UDID: string;

}
``` 



    