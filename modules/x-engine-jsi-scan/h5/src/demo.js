
import scan from './index.js'
import xengine from "@zkty-team/x-engine-core";

window.test_openScanView = () => {

    xengine.api("com.zkty.jsi.scan", "openScanView", {}, (val) => {
      document.getElementById("debug_text").innerText = JSON.stringify(val);
    });
  }
 document.getElementById("test_openScanView").click()
      
    