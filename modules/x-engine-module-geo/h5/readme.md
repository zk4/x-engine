
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
 
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| type | string | true | wgs84 |  默认为 wgs84 返回 gps 坐标，gcj02 返回国测局坐标 |


## locate



**demo**
``` js
{
  window.locate = () => {
    geo
      .locate({
          __event__:function(res){
        //GeoLocationResDTO
        res = JSON.parse(res);
        document.getElementById("debug_text").innerText = "long,lat,locs:"+ res["longitude"]+res["latitude"]+res["country"]+res["province"]+res["city"]+res["district"]+res["street"];
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
| type | string |  | wgs84 |  |
| \_\_event\_\_ |  | true |  |  |

    