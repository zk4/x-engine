
import enviroment from './index.js'
import xengine from "@zkty-team/x-engine-core";

window.test_isHybrid = () => {

  let val = xengine.api("com.zkty.jsi.enviroment", "isHybird");
  document.getElementById("debug_text").innerText = JSON.stringify(val);
  xengine.assert('test_isHybrid', val.code ===0 && val.msg==="" )
}
 document.getElementById("test_isHybrid").click()
        
    