// 命名空间
const moduleID = "com.zkty.module.geo";

// interface GeoReqDTO {
//   // 默认为 WGS84 返回 gps 坐标，GCJ02 返回国测局坐标
//   type?: string;
// }

interface GeoEventDTO {
  // 默认为 BMK09LL 返回 BMK 坐标，GCJ02 返回国测局坐标,WGS84 返回 gps 坐标,BMK09MC 返回 BMK 坐标
  type: string;
  __event__?:(string)=>{};
}

// interface GeoResDTO {
//   // 目标地经度
//   longitude: string;
//   // 目标地纬度
//   latitude: string;
// }

// // 经纬度反查参数,如果不传，则根据当前经实时经纬度返回
// interface GeoReverseReqDTO {
//   // 坐标类型
//   type?: string;
//   // 目标地经度
//   longitude?: string;
//   // 目标地纬度
//   latitude?: string;
// }
// 单次定位返回
interface GeoLocationResDTO {
  // 目标地经度
  longitude: string;
  // 目标地纬度
  latitude: string;
  //国家名字
  country: string;

  //省名字
  province: string;
  //城市名字
  city: string;
  //区名字
  district: string;
  //乡镇
  town: string;
  //街道
  street: string;
}
/*
单次定位，返回经纬度和位置信息
*/
function locate(args:GeoEventDTO = {type:"WGS84"}){
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

