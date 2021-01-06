
version: 0.1.7
``` bash
npm install @zkty-team/x-engine-module-geo
```



## locate


单次定位，返回经纬度和位置信息


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
| type | string | 必填 | BMK09LL |  默认为 BMK09LL 返回 BMK 坐标，GCJ02 返回国测局坐标,WGS84 返回 gps 坐标,BMK09MC 返回 BMK 坐标 |
| \_\_event\_\_ | _0_com.zkty.module.geo_DTO | optional |  |  |

**返回值**
**无参数**



    