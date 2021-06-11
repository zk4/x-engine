
import webcache from './index.js'
import xengine from "@zkty-team/x-engine-core";

window.test_同步无返回 = () => {

  let val = xengine.api("com.zkty.jsi.webcache", "simpleMethod");
  document.getElementById("debug_text").innerText = "无返回,查看原生控制台打印";
}
 document.getElementById("test_同步无返回").click()
        
    