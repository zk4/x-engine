
import geo from './index.js'
import xengine from "@zkty-team/x-engine-core";

window.test_locate = () => {

  xengine.api("com.zkty.jsi.geo", "locate",(val)=>{
  document.getElementById("debug_text").innerText = JSON.stringify(val);

  });
}
 document.getElementById("test_locate").click()
        
    