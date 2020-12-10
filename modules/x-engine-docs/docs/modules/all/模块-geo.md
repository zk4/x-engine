

**基座扫描测试**
<div id='modulename' style='display:none'>geo</div> <img id='qrimg' src='https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=http://192.168.44.52:3000/docs/modules/all/dist/ui/index.html'></img>
<a id='qrlink' href="about:none">link of QR</a>



# JS


version: 0.0.59
``` bash
npm install @zkty-team/x-engine-module-geo
```



## coordinate



**demo**
``` js
 {
    window.coordinate = (...args) => {
    geo
      .coordinate(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "long,lat:"+res["longitude"]+res["latitude"];
      });
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| type | string | true |  |  默认为 wgs84 返回 gps 坐标，gcj02 返回国测局坐标 |


## locate



**demo**
``` js
 {
    window.locate = (...args) => {
    geo
      .locate(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "hello";
      });
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| type | string | true |  |  坐标类型 |
| longitude | string | true |  |  目标地经度 |
| latitude | string | true |  |  目标地纬度 |

    

# iOS


# android


