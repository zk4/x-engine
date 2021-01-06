
version: 0.1.7
``` bash
npm install @zkty-team/x-engine-module-scan
```



## openScanView



**demo**
``` js
 {
  window.openScanView = (...args) => {
    scan
      .openScanView({
        __event__: (res) => {
          document.getElementById("debug_text").innerText = res;
        },
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = JSON.stringify(res);
      });
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| \_\_event\_\_ | _0_com.zkty.module.scan_DTO | 必填 | (result) => {} | 扫码结果 xx(result) |

**返回值**
**无参数**



    