


相当于浏览器里的 localstorage.  
默认在 App 界面 Deactive 时,数据会进行持久化. 

> 与 globalstorage 的区别在于,  A 微应用只能在 localstorage 对 A 的数据进行操作. 而不能对 B 的 localstorage 做任何操作.
> globalstorage 则是全局的.



JSI Id: com.zkty.jsi.localstorage

version: 2.9.0



## get
[`sync`](/docs/modules/模块-规范?id=jsi-调用)



> **demo**
``` js

  let val = xengine.api("com.zkty.jsi.localstorage", "get",
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

  xengine.api("com.zkty.jsi.localstorage", "set",{
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


    

