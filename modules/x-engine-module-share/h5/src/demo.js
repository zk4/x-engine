
import share from './index.js'
import xengine from "@zkty-team/x-engine-module-engine";


  window.share = () => {
    share
      .share({
        __event__: (res) => {
          document.getElementById("debug_text").innerText = JSON.stringify(res);
        },
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = res;
      });
  };

    