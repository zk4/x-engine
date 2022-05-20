// model.ts 解析版本
const parserVersion = "1.0.0";

// 命名空间
const moduleID = "com.zkty.jsi.geo";

const conf = {
  args: {},
  permissions: {
    X_USER_INFO: "READ",
    X_LBS: "READ_WRITE",
    X_PHOTO: "READ",
  },
};
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

interface LocationStatusDTO {
   //  0:手机开启定位服务且app已授权
   // -1:手机开启定位服务但app未授权
   // -2:手机未开启定位服务
  code: int;
  msg: string;
  
} 


// 获取单次定位信息
@async
function locate():LocationDTO  {
  xengine.api("com.zkty.jsi.geo", "locate",(val)=>{
  document.getElementById("debug_text").innerText = JSON.stringify(val);
  });
}

// 获取定位服务状态
@async
function locatable():LocationStatusDTO  {
  xengine.api("com.zkty.jsi.geo", "locatable",(val)=>{
  document.getElementById("debug_text").innerText = JSON.stringify(val);
  });
}


function test_locate() {
  xengine.api("com.zkty.jsi.geo", "locate",(val)=>{
  document.getElementById("debug_text").innerText = JSON.stringify(val);

  });
}
  
  
  
  
  
  
