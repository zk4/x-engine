
import dev from './index.js'
import xengine from "@zkty-team/x-engine-core";

window.test_同步无返回 = () => {

  let val = xengine.api("com.zkty.jsi.dev", "log","hello,nativelog");
  document.getElementById("debug_text").innerText = val;
}
 document.getElementById("test_同步无返回").click()
      
    