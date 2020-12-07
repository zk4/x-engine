
import share from './index.js'

    window.share = (...args) => {
    share
      .share(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:"+res["code"];
      });
  };

    