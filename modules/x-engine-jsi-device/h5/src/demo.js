
import device from './index.js'
import xengine from "@zkty-team/x-engine-core";

window.getStatusBarHeight = () => {
}
 document.getElementById("getStatusBarHeight").click()
    window.getNavigationHeight = () => {
}
 document.getElementById("getNavigationHeight").click()
    window.getScreenHeight = () => {
}
 document.getElementById("getScreenHeight").click()
    window.getTabbarHeight = () => {
}
 document.getElementById("getTabbarHeight").click()
    window.getSystemVersion = () => {
}
 document.getElementById("getSystemVersion").click()
    window.getUUID = () => {
}
 document.getElementById("getUUID").click()
    window.callPhone = () => {
}
 document.getElementById("callPhone").click()
    window.sendMessage = () => {
}
 document.getElementById("sendMessage").click()
    window.getDeviceInfo = () => {
}
 document.getElementById("getDeviceInfo").click()
    window.getDeviceInfo1 = () => {
}
 document.getElementById("getDeviceInfo1").click()
    window.test_getStatusHeight = () => {

  let val = xengine.api("com.zkty.jsi.device", "getStatusBarHeight");
  document.getElementById("debug_text").innerText = typeof val + ":" + val;
}
 document.getElementById("test_getStatusHeight").click()
    window.test_getNavHeight = () => {

  let val = xengine.api("com.zkty.jsi.device", "getNavigationHeight");
  document.getElementById("debug_text").innerText = typeof val + ":" + val;
}
 document.getElementById("test_getNavHeight").click()
    window.text_getScreenHeight = () => {

  let val = xengine.api("com.zkty.jsi.device", "getScreenHeight");
  document.getElementById("debug_text").innerText = typeof val + ":" + val;
}
 document.getElementById("text_getScreenHeight").click()
    window.text_getTabbarHeight = () => {

  let val = xengine.api("com.zkty.jsi.device", "getTabbarHeight");
  document.getElementById("debug_text").innerText = typeof val + ":" + val;
}
 document.getElementById("text_getTabbarHeight").click()
    window.text_callPhone = () => {

  xengine.api("com.zkty.jsi.device", "callPhone", {
    phoneNum: "18637369306",
    phoneMsg: ''
  });
}
 document.getElementById("text_callPhone").click()
    window.text_sendMsg = () => {

  xengine.api("com.zkty.jsi.device", "sendMessage", {
    phoneNum: "18637369306",
    phoneMsg: '你好'
  });
}
 document.getElementById("text_sendMsg").click()
    window.text_getDeviceInfo = () => {

  let val = xengine.api("com.zkty.jsi.device", "getDeviceInfo");
  document.getElementById("debug_text").innerText = typeof val + ":" + val;
}
 document.getElementById("text_getDeviceInfo").click()
    window.text_getDeviceInfo1 = () => {

  xengine.api("com.zkty.jsi.device", "getDeviceInfo1", {}, (val) => {
   document.getElementById("debug_text").innerText = typeof val + ":" + val;
  });
}
 document.getElementById("text_getDeviceInfo1").click()
    
    