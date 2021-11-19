





JSI Id: com.zkty.jsi.geo

version: 3.0.3



## locate
[`async`](/docs/modules/模块-规范?id=jsi-调用)
 获取单次定位信息


> **demo**
``` js

  xengine.api("com.zkty.jsi.geo", "locate",(val)=>{
  document.getElementById("debug_text").innerText = JSON.stringify(val);
  });

``` 

**无参数**


**返回值**
``` js

interface LocationDTO {

   // 目标地经度
  longitude: string;
  // 目标地纬度
  latitude: string;
  // 地址
  address:string;
  // 国家名字
  country: string;
  // 省名字
  province: string;
  // 城市名字
  city: string;
  // 区名字
  district: string;
  // 街道
  street: string;
  
  
  

}
``` 


    

