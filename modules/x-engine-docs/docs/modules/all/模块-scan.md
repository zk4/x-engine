

**基座扫描测试**
<div id='modulename' style='display:none'>scan</div> <img id='qrimg' src='https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=http://192.168.44.52:3000/docs/modules/all/dist/ui/index.html'></img>
<a id='qrlink' href="about:none">link of QR</a>

扫描模块


# JS


version: 0.1.11
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

        document.getElementById("debug_text").innerText = typeof(res)+":"+JSON.stringify(res);
      });
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| \_\_event\_\_ | _0_com.zkty.module.scan_DTO | 必填 | (result) => {} | 扫码结果 xx(result) |


参数 object  定义
``` js


interface ScanOpenDto {

  //扫码结果 xx(result)
  __event__: (index: string) => void;

}
``` 


---------------------
**无返回值**



    

# iOS


# android


