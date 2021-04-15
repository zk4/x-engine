
import secrect from './index.js'
import xengine from "@zkty-team/x-engine-module-engine";

window.get = () => {

  window.get = () => {
    secrect
      .get({
        key: "key"
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = JSON.stringify(res);
      });
  };
}
 document.getElementById("get").click()
    
    