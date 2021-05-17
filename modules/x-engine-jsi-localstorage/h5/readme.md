

JSI Id: com.zkty.jsi.localstorage

version: 0.1.13



## get
`sync`

**demo**
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
`sync`

**demo**
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


    