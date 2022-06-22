
import browser from './index.js'
import xengine from "@zkty-team/x-engine-core";

window.test_open = () => {

  xengine.api("com.zkty.jsi.browser", "open",{
        "url":"https://wwww.baidu.com"        
    } ,(val) => {
      document.getElementById("debug_text").innerText = JSON.stringify(val);
    });
}
 document.getElementById("test_open").click()
        
    