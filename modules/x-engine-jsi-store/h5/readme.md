

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


    