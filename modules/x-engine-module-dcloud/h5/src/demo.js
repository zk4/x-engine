
import dcloud from './index.js'
import xengine from "@zkty-team/x-engine-module-engine";


  window.openUniMP = () => {
    dcloud.openUniMP().then((res) => {
      document.getElementById("debug_text").innerText = "ret:"+res;
    });
 };

  window.preloadUniMP = () => {
    dcloud.preloadUniMP().then((res) => {
      document.getElementById("debug_text").innerText = "ret:"+res;
    });
 };

  window.openUniMPWithArg = () => {
    dcloud.openUniMPWithArg().then((res) => {
      document.getElementById("debug_text").innerText = "ret:"+res;
    });
 };

    