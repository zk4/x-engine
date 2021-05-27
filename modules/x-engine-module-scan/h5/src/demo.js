
import scan from './index.js'
import xengine from "@zkty-team/x-engine-module-engine";

window.openScanView = () => {

  window.openScanView = (...args) => {
    scan
      .openScanView({
        __event__: (res) => {
          document.getElementById("debug_text").innerText = res;
        },
      })
      .then((res) => {

        document.getElementById("debug_text").innerText = typeof(res)+":"+JSON.stringify(res);
      });
  };
}
 document.getElementById("openScanView").click()
    
    