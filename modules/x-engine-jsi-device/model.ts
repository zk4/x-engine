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
  // 当前语言
  language: string;
  // 设备版本
  UUID: string;
}

// 获取状态栏高度
@sync
function getStatusBarHeight(): string {
  function test_getStatusHeight() {
    let val = xengine.api("com.zkty.jsi.device", "getStatusBarHeight");
    document.getElementById("debug_text").innerText = typeof val + ":" + val;
  }}
// 获取导航条高度
@sync
function getNavigationHeight(): string {}
// 获取屏幕高度
@sync
function getScreenHeight(): string {}
// 获取tabBar高度
@sync
function getTabbarHeight(): string {}
// 打电话
@sync
function callPhone(arg: phoneDto): string {}
// 发短信
@sync
function sendMessage(arg: phoneDto): string {}
// 获取设备信息
@async
function getDeviceInfo(): DeviceDTO {}


function test_getNavHeight() {
  let val = xengine.api("com.zkty.jsi.device", "getNavigationHeight");
  document.getElementById("debug_text").innerText = typeof val + ":" + val;
}

function test_getScreenHeight() {
  let val = xengine.api("com.zkty.jsi.device", "getScreenHeight");
  document.getElementById("debug_text").innerText = typeof val + ":" + val;
}

function test_getTabbarHeight() {
  let val = xengine.api("com.zkty.jsi.device", "getTabbarHeight");
  document.getElementById("debug_text").innerText = typeof val + ":" + val;
}

function test_callPhone() {
  xengine.api("com.zkty.jsi.device", "callPhone", {
    phoneNum: "18637369306",
    phoneMsg: ''
  });
}

function test_sendMsg() {
  xengine.api("com.zkty.jsi.device", "sendMessage", {
    phoneNum: "18637369306",
    phoneMsg: '你好'
  });
}

function test_getDeviceInfo () {
  xengine.api("com.zkty.jsi.device", "getDeviceInfo", {}, (val) => {
   document.getElementById("debug_text").innerText = JSON.stringify(val);
  });
}