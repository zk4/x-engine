

**基座扫描测试**
<div id='modulename' style='display:none'>store</div> <img id='qrimg' src='https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=http://192.168.44.52:3000/docs/modules/all/dist/ui/index.html'></img>
<a id='qrlink' href="about:none">link of QR</a>



# JS


JSI Id: com.zkty.jsi.store

version: 0.1.13



## get
`sync` `async`


**demo**
``` js

  function test_getObject(arg: { key: string }): string {
    xengine.api("com.zkty.jsi.store", "get", { key: "obj" }, (val) => {
      document.getElementById("debug_text").innerText = typeof val + ":" + val;
    });
  }

``` 

**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| key | string | 必填 |  |  |
**返回值**
``` js
string
``` 



## set
`async` `sync`


**demo**
``` js

  function test_setObject(arg: ZKStoreEntryDTO) {
    xengine.api(
      "com.zkty.jsi.store",
      "set",
      {
        key: "obj",
        val: JSON.stringify({ key: { a: "a", b: [1, 2, 3], c: { d: "d" } } }),
      },
      (res) => {
        console.log(res);
      }
    );
  }

``` 

**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| key | string | 必填 |  |  |
| val | string | 必填 |  | 不可为空 |
**无返回值**


    

# iOS


# android


