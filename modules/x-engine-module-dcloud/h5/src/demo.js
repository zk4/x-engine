
import dcloud from './index.js'
import xengine from "@zkty-team/x-engine-module-engine";

window.openUniMP = () => {

  window.openUniMP = () => {
    dcloud.openUniMP({
    appId:'__UNI__9B75743'
  }).then((res) => {
      document.getElementById("debug_text").innerText = "ret:"+res;
    });
 };
}
 document.getElementById("openUniMP").click()
    window.testopenUniMP = () => {

  window.testopenUniMP = () => {
    dcloud.openUniMP({
    appId:'__UNI__3E0722D'
  }).then((res) => {
      document.getElementById("debug_text").innerText = "ret:"+res;
    });
 };
}
 document.getElementById("testopenUniMP").click()
    window.preloadUniMP = () => {

  window.preloadUniMP = (
    
  ) => {
    dcloud.preloadUniMP({
    appId:'__UNI__11E9B73',
    arguments:{'token':'this is token','refreshtoken':'this is refreshtoken'},
    redirectPath:'pages/component/application/application?token=a&refreshtoken=b',
    enableBackground:false,
  }).then((res) => {
      document.getElementById("debug_text").innerText = "ret:"+res;
    });
 };
}
 document.getElementById("preloadUniMP").click()
    window.openUniMPWithArg = () => {

  window.openUniMPWithArg = () => {
    dcloud.openUniMPWithArg({
    appId:'__UNI__9B75743',
    arguments:{'token':'this is token','refreshtoken':'this is refreshtoken'},
    redirectPath:'pages/component/application/application?token=a&refreshtoken=b',
    enableBackground:false,
  }).then((res) => {
      document.getElementById("debug_text").innerText = "ret:"+res;
    });
 };
}
 document.getElementById("openUniMPWithArg").click()
    
    