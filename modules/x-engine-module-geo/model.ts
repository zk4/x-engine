// 命名空间
const moduleID = "com.zkty.module.geo";

interface GeoReqDTO {
  // 默认为 wgs84 返回 gps 坐标，gcj02 返回国测局坐标
  type?: string;
}

interface GeoResDTO {
  // 目标地经度
  longitude: string;
  // 目标地纬度
  latitude: string;
}

// 经纬度反查参数,如果不传，则根据当前经实时经纬度返回
interface GeoReverseReqDTO {
  // 坐标类型
  type?: string;
  // 目标地经度
  longitude?: string;
  // 目标地纬度
  latitude?: string;
}
// 经纬度反查参数
interface GeoReverseResDTO {
  // 目标地经度
  longitude: string;
  // 目标地纬度
  latitude: string;
}


function coordinate(arg:GeoReqDTO={title:"wgs84"}):GeoResDTO {
    window.coordinate = (...args) => {
    geo
      .coordinate(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "long,lat:"+res["longitude"]+res["latitude"];
      });
  };
}

function locate(arg:GeoReverseReqDTO):GeoReverseResDTO {
    window.locate = (...args) => {
    geo
      .locate(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "hello";
      });
  };
}


