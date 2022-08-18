
import device from './index.js'
import xengine from "@zkty-team/x-engine-core";

window.test_getStatusHeight = () => {
 {
  let val = xengine.api("com.zkty.jsi.device", "getStatusBarHeight");
  document.getElementById("debug_text").innerText = typeof val + ":" + val;
}}
 document.getElementById("test_getStatusHeight").click()
        window.test_getNavHeight = () => {
 {
  let val = xengine.api("com.zkty.jsi.device", "getNavigationHeight");
  document.getElementById("debug_text").innerText = typeof val + ":" + val;
}}
 document.getElementById("test_getNavHeight").click()
        window.test_getScreenHeight = () => {
 {
  let val = xengine.api("com.zkty.jsi.device", "getScreenHeight");
  document.getElementById("debug_text").innerText = typeof val + ":" + val;
}}
 document.getElementById("test_getScreenHeight").click()
        window.test_getTabbarHeight = () => {
 {
  let val = xengine.api("com.zkty.jsi.device", "getTabbarHeight");
  document.getElementById("debug_text").innerText = typeof val + ":" + val;
}}
 document.getElementById("test_getTabbarHeight").click()
        window.test_callPhone = () => {
 {
  xengine.api("com.zkty.jsi.device", "callPhone", {
    phoneNum: "18637369306",
    phoneMsg: "",
  });
}}
 document.getElementById("test_callPhone").click()
        window.test_sendMsg = () => {
 {
  xengine.api("com.zkty.jsi.device", "sendMessage", {
    phoneNum: "18637369306",
    phoneMsg: "你好",
  });
}}
 document.getElementById("test_sendMsg").click()
        window.test_getDeviceInfo = () => {
 {
  xengine.api("com.zkty.jsi.device", "getDeviceInfo", {}, (val) => {
    document.getElementById("debug_text").innerText = JSON.stringify(val);
  });
}}
 document.getElementById("test_getDeviceInfo").click()
        window.test_pickContact = () => {
 {
  xengine.api("com.zkty.jsi.device", "pickContact", {}, (val) => {
    document.getElementById("debug_text").innerText = JSON.stringify(val);
  });
}}
 document.getElementById("test_pickContact").click()
        
    