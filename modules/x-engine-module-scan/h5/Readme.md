

JSI Id: com.zkty.module.scan

version: 0.1.13



## openScanView



**demo**
``` js

  window.openScanView = (...args) => {
    scan
      .openScanView({
        __event__: (res) => {
          document.getElementById("debug_text").innerText = res;
        },
      })
      .then((res) => {

        document.getElementById("debug_text").innerText = typeof(res)+":"+JSON.stringify(res);
      });
  };

``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| \_\_event\_\_ | _0_com.zkty.module.scan_DTO | 必填 | (result) => {} | 扫码结果 xx(result) |


---------------------
**无返回值**



    