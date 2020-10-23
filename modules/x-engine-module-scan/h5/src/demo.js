
import scan from './index.js'

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

    