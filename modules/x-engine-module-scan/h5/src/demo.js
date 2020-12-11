
import scan from './index.js'
import xengine from "@zkty-team/x-engine-module-engine";


  window.openScanView = (...args) => {
    scan
      .openScanView({
        __event__: (res) => {
          document.getElementById("debug_text").innerText = res;
        },
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = JSON.stringify(res);
      });
  };

    