

JSI Id: com.zkty.jsi.globalstorage

version: 3.0.7



## get
[`sync`](/docs/modules/模块-规范?id=jsi-调用)



> **demo**
``` js

  let val = xengine.api("com.zkty.jsi.globalstorage", "get",
    'abc',
  );
  console.log(val);

``` 

**无参数**


**返回值**
``` js
string
``` 



## set
[`sync`](/docs/modules/模块-规范?id=jsi-调用)



> **demo**
``` js

  xengine.api("com.zkty.jsi.globalstorage", "set",{
    key:'abc',
    val:'world'
  });

``` 

**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| key | string | 必填 |  |  |
| val | string | 必填 |  |  |

**无返回值**



## del
[`sync`](/docs/modules/模块-规范?id=jsi-调用)



> **demo**
``` js

 xengine.api("com.zkty.jsi.globalstorage", "del",
    'abc',
  );

``` 

**无参数**


**无返回值**


    