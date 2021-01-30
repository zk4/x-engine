// 命名空间
const moduleID = "com.zkty.module.lope";

// dto
//初始化sdk
interface LopePIDDTO {
  // pid
  pid:string;
  // 初始化结果回调函数
  __event__: (string)=>void,
}

//扫描外设
interface LopeScanDTO {
  // 扫描周期，推荐0.15，即150毫秒
  interval:int;
  //扫描的uuid范围
  serviceUUIDs:Array<string>,
  //是否扫到第一个设备后立即停止扫描并回调
  immediately:boolean,
  // 扫描结果回调函数
  __event__: (string)=>void,
}

//开门
interface OpenDoorDTO{
  // 门禁设备信息将导出给接入方, 包括MAC，秘钥等基本信息
  locks: Array<Map<string,string>>;
  // 开门结果回调函数
  __event__: (string)=>void,
}

//点亮梯控
interface LightLiftDTO{
  //梯控设备mac
  mac:string,
  //梯控设备输出口编号
  ioIndex:int,
  // 开门结果回调函数
  __event__: (string)=>void,
}

interface LopeRetStatusDTO{
  //返回状态
  status:string,
  //返回状态值
  code:string
}

//初始化蓝牙Sdk
function initSdkAndConfigure(
  LopePIDDTO: LopePIDDTO = {
    pid:"03jfuto709chalfwo84nf921qujt5p",
    __event__: (string)=>{},
  }
):LopeRetStatusDTO{
  window.initSdkAndConfigure = () => {
    lope
      .initSdkAndConfigure({
        __event__: (res) => {
          document.getElementById("debug_text").innerText = res;
        },
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = res;
      });
  };
}

//初始化蓝牙Sdk
function scanDevice(
  LopeScanDTO: LopeScanDTO = {
    interval:1,
    serviceUUIDs:['2560','FEE7'],
    immediately:false,
    __event__: (string)=>{},
  }
):LopeRetStatusDTO{
  window.scanDevice = () => {
    lope
      .scanDevice({
        __event__: (res) => {
          document.getElementById("debug_text").innerText = res;
        },
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = res;
      });
  };
}


function openDoor(
  OpenDoorDTO: OpenDoorDTO = {
    locks:[{"mac":"00:18:E4:0C:73:89", "key": "12345678"},{"mac":"00:18:E4:0C:6C:21", "key": "12345678"}],
  __event__: (string)=>{},
}):LopeRetStatusDTO{
  window.openDoor = () => {
  lope
    .openDoor({
      __event__: (res) => {
        document.getElementById("debug_text").innerText = res;
      },
    })
    .then((res) => {
      document.getElementById("debug_text").innerText = "ret:"+res;
    });
  };

}

function lightLift(
  LightLiftDTO:LightLiftDTO = {
    mac:'B0:7E:11:F4:D9:94',
    ioIndex:4,
    __event__: (string)=>{},
  }){
  window.lightLift = (...args) => {
  lope
    .lightLift({
      __event__: (res) => {
        document.getElementById("debug_text").innerText = res;
      },
    })
    .then((res) => {
      document.getElementById("debug_text").innerText = "ret:"+res;
    });
  };

}

