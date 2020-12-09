
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

	
**无参数**




## locate__event__



**demo**
``` js
 {
  window.locate__event__ = () => {
    geo
      .locate__event__({
          __event__:function(res){
        res = JSON.parse(res);
        document.getElementById("debug_text").innerText = "long,lat,locs:"+ res["longitude"]+res["latitude"]+res["locationString"];
        //document.getElementById("debug_text").innerText=res ;
        return res;
          }
        }
      )
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| \_\_event\_\_ |  | true |  |  |

    