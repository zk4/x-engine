// model.ts 解析版本
const parserVersion = "1.0.0";

// 命名空间
const moduleID = "com.zkty.jsi.device";

const conf = {
  args: {},
  permissions: {
    X_USER_INFO: "READ",
    X_LBS: "READ_WRITE",
    X_PHOTO: "READ",
  },
}

// 电话模型
interface phoneDto {
  // 设备类型
  phoneNum: string;
  // 设备版本
  phoneMsg: string;
}

// 设备模型
interface DeviceDTO {
  // 设备类型
  type: string;
  // 设备版本
  systemVersion: string;
  // 设备类型
  language: string;
  // 设备版本
  UUID: string;
}

// 获取状态栏高度
@sync
function getStatusBarHeight(): string {}
// 获取导航条高度
@sync
function getNavigationHeight(): string {}
// 获取屏幕高度
@sync
function getScreenHeight(): string {}
// 获取tabBar高度
@sync
function getTabbarHeight(): string {}
// 获取系统版本
@sync 
function getSystemVersion(): string {}
// 获取iOS设备的UUID
@sync 
function getUUID(): string {}
// 打电话
@sync
function callPhone(arg: phoneDto): string {}
// 发短信
@sync
function sendMessage(arg: phoneDto): string {}
// 获取设备信息
@sync
function getDeviceInfo(): string {}
// 获取设备信息
@async
function getDeviceInfo1(): DeviceDTO {}


function test_getStatusHeight() {
  let val = xengine.api("com.zkty.jsi.device", "getStatusBarHeight");
  document.getElementById("debug_text").innerText = typeof val + ":" + val;
}

function test_getNavHeight() {
  let val = xengine.api("com.zkty.jsi.device", "getNavigationHeight");
  document.getElementById("debug_text").innerText = typeof val + ":" + val;
}

function text_getScreenHeight() {
  let val = xengine.api("com.zkty.jsi.device", "getScreenHeight");
  document.getElementById("debug_text").innerText = typeof val + ":" + val;
}

function text_getTabbarHeight() {
  let val = xengine.api("com.zkty.jsi.device", "getTabbarHeight");
  document.getElementById("debug_text").innerText = typeof val + ":" + val;
}

function text_callPhone() {
  xengine.api("com.zkty.jsi.device", "callPhone", {
    phoneNum: "18637369306",
    phoneMsg: ''
  });
}

function text_sendMsg() {
  xengine.api("com.zkty.jsi.device", "sendMessage", {
    phoneNum: "18637369306",
    phoneMsg: '你好'
  });
}

function text_getDeviceInfo () {
  let val = xengine.api("com.zkty.jsi.device", "getDeviceInfo");
  document.getElementById("debug_text").innerText = typeof val + ":" + val;
}

function text_getDeviceInfo1 () {
  xengine.api("com.zkty.jsi.device", "getDeviceInfo1", {}, (val) => {
   document.getElementById("debug_text").innerText = typeof val + ":" + val;
  });
}

// // 设备类型 iPhone or android
// @sync
// function getPhoneType(): { type: string} {}
// // 系统版本
// @sync
// function getSystemVersion():{ version:string }{}


// 导航条高度
// @sync
// function getNavigationHeight():{ height:string }{}


// dto
// interface DeviceSheetDTO {
//   //回调方法
//   __event__: (string)=>void;
// }
// interface DeviceMoreDTO {
//   //返回值
//   content: string;
// }

// interface DevicePhoneNumDTO {
//   //手机号
//   phoneNumber: string;
// }

// interface DeviceMessageDTO {
//   //手机号
//   phoneNumber: string;
//   //短信内容
//   messageContent:string;
// }

// //设备类型
// function getPhoneType(
//   DeviceSheetDTO: DeviceSheetDTO = {
//     __event__: (string)=>{},
//   }
// ):DeviceMoreDTO {
//   window.getPhoneType = () => {
//     device
//       .getPhoneType({
//         __event__: (res) => {
//           document.getElementById("debug_text").innerText = res;
//         },
//       })
//       .then((res) => {
//         document.getElementById("debug_text").innerText = res;
//       });
//   };
// }

// //系统版本
// function getSystemVersion(
//   DeviceSheetDTO: DeviceSheetDTO = {
//     __event__: (string)=>{},
//   }
// ):DeviceMoreDTO{
//   window.getSystemVersion = () => {
//     device
//       .getSystemVersion({
//         __event__: (res) => {
//           document.getElementById("debug_text").innerText = res;
//         },
//       })
//       .then((res) => {
//         document.getElementById("debug_text").innerText = res;
//       });
//   };
// }

// //UDID
// function getUDID(
//   DeviceSheetDTO: DeviceSheetDTO = {
//     __event__: (string)=>{},
//   }
// ):DeviceMoreDTO{
//   window.getUDID = () => {
//     device
//       .getUDID({
//         __event__: (res) => {
//           document.getElementById("debug_text").innerText = res;
//         },
//       })
//       .then((res) => {
//         document.getElementById("debug_text").innerText = res;
//       });
//   };
// }

// //电池电量
// function getBatteryLevel(
//   DeviceSheetDTO: DeviceSheetDTO = {
//     __event__: (string)=>{},
//   }
// ):DeviceMoreDTO{
//   window.getBatteryLevel = () => {
//     device
//       .getBatteryLevel({
//         __event__: (res) => {
//           document.getElementById("debug_text").innerText = res;
//         },
//       })
//       .then((res) => {
//         document.getElementById("debug_text").innerText = res;
//       });
//   };
// }

// //当前语言
// function getPreferredLanguage(
//   DeviceSheetDTO: DeviceSheetDTO = {
//     __event__: (string)=>{},
//   }
// ):DeviceMoreDTO{
//   window.getPreferredLanguage = () => {
//     device
//       .getPreferredLanguage({
//         __event__: (res) => {
//           document.getElementById("debug_text").innerText = res;
//         },
//       })
//       .then((res) => {
//         document.getElementById("debug_text").innerText = res;
//       });
//   };
// }

// //屏幕宽度
// function getScreenWidth(
//   DeviceSheetDTO: DeviceSheetDTO = {
//     __event__: (string)=>{},
//   }
// ):DeviceMoreDTO{
//   window.getScreenWidth = () => {
//     device
//       .getScreenWidth({
//         __event__: (res) => {
//           document.getElementById("debug_text").innerText = res;
//         },
//       })
//       .then((res) => {
//         document.getElementById("debug_text").innerText = res;
//       });
//   };
// }

// //屏幕高度
// function getScreenHeight(
//   DeviceSheetDTO: DeviceSheetDTO = {
//     __event__: (string)=>{},
//   }
// ):DeviceMoreDTO{
//   window.getScreenHeight = () => {
//     device
//       .getScreenHeight({
//         __event__: (res) => {
//           document.getElementById("debug_text").innerText = res;
//         },
//       })
//       .then((res) => {
//         document.getElementById("debug_text").innerText = res;
//       });
//   };
// }

// //安全区域上边距
// function getSafeAreaTop(
//   DeviceSheetDTO: DeviceSheetDTO = {
//     __event__: (string)=>{},
//   }
// ):DeviceMoreDTO{
//   window.getSafeAreaTop = () => {
//     device
//       .getSafeAreaTop({
//         __event__: (res) => {
//           document.getElementById("debug_text").innerText = res;
//         },
//       })
//       .then((res) => {
//         document.getElementById("debug_text").innerText = res;
//       });
//   };
// }

// //安全区域下边距
// function getSafeAreaBottom(
//   DeviceSheetDTO: DeviceSheetDTO = {
//     __event__: (string)=>{},
//   }
// ):DeviceMoreDTO{
//   window.getSafeAreaBottom = () => {
//     device
//       .getSafeAreaBottom({
//         __event__: (res) => {
//           document.getElementById("debug_text").innerText = res;
//         },
//       })
//       .then((res) => {
//         document.getElementById("debug_text").innerText = res;
//       });
//   };
// }

// //安全区域左边距
// function getSafeAreaLeft(
//   DeviceSheetDTO: DeviceSheetDTO = {
//     __event__: (string)=>{},
//   }
// ):DeviceMoreDTO{
//   window.getSafeAreaLeft = () => {
//     device
//       .getSafeAreaLeft({
//         __event__: (res) => {
//           document.getElementById("debug_text").innerText = res;
//         },
//       })
//       .then((res) => {
//         document.getElementById("debug_text").innerText = res;
//       });
//   };
// }

// //安全区域右边距
// function getSafeAreaRight(
//   DeviceSheetDTO: DeviceSheetDTO = {
//     __event__: (string)=>{},
//   }
// ):DeviceMoreDTO{
//   window.getSafeAreaRight = () => {
//     device
//       .getSafeAreaRight({
//         __event__: (res) => {
//           document.getElementById("debug_text").innerText = res;
//         },
//       })
//       .then((res) => {
//         document.getElementById("debug_text").innerText = res;
//       });
//   };
// }

// //状态栏高度
// function getStatusHeight(
//   DeviceSheetDTO: DeviceSheetDTO = {
//     __event__: (string)=>{},
//   }
// ):DeviceMoreDTO{
//   window.getStatusHeight = () => {
//     device
//       .getStatusHeight({
//         __event__: (res) => {
//           document.getElementById("debug_text").innerText = res;
//         },
//       })
//       .then((res) => {
//         document.getElementById("debug_text").innerText = res;
//       });
//   };
// }


//tabBar高度
// function getTabBarHeight(
//   DeviceSheetDTO: DeviceSheetDTO = {
//     __event__: (string)=>{},
//   }
// ):DeviceMoreDTO{
//   window.getTabBarHeight = () => {
//     device
//       .getTabBarHeight({
//         __event__: (res) => {
//           document.getElementById("debug_text").innerText = res;
//         },
//       })
//       .then((res) => {
//         document.getElementById("debug_text").innerText = res;
//       });
//   };
// }

// //打电话
// function devicePhoneCall(arg:DevicePhoneNumDTO){
//   window.devicePhoneCall = (...args) => {
//   device
//     .devicePhoneCall({phoneNumber:"10086"})
//     .then((res) => {
//       document.getElementById("debug_text").innerText = "ret:"+res;
//     });
// };
// }

// //发短信
// function deviceSendMessage(
//   DeviceMessageDTO: DeviceMessageDTO
// ):DeviceMoreDTO{
//   window.deviceSendMessage = () => {
//     device
//       .deviceSendMessage({
//         phoneNumber:"10086",
//         messageContent:"1111111111",
//       });
//   };
// }