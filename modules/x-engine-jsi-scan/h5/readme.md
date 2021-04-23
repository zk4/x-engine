

JSI Id: com.zkty.jsi.scan

version: 0.1.13



## openScanView
`async`

**demo**
``` js

  function test_openScanView() {
    xengine.api("com.zkty.jsi.scan", "openScanView", {}, (val) => {
      document.getElementById("debug_text").innerText = JSON.stringify(val);
    });
  }

``` 

**无参数**

**返回值**
``` js
string
``` 


    