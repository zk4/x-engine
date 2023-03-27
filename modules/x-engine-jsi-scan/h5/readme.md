

JSI Id: com.zkty.jsi.scan

version: 3.0.7



## openScanView
[`async`](/docs/modules/模块-规范?id=jsi-调用)



> **demo**
``` js
 {
  xengine.api("com.zkty.jsi.scan", "openScanView", {}, (val) => {
    console.log(JSON.stringify(val))
  });
}
``` 

**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| routerUrl | string | optional |  | 扫描失败跳转地址 |

**返回值**
``` js
string
``` 


    