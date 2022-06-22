


所有微应用的公共数据交换区域. 没有权限区别. 一般用于非关键业务数据交换. 
使用注意: 为了防止公共数据被误覆盖, 在 set 已经存在的 key 时, 将会有弹窗警告. 需要开发者显示的 del 掉已存在的 key. 



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


    

