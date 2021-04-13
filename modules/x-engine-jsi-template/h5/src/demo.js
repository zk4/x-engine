
import xxxx from './index.js'
import xengine from "@zkty-team/x-engine-module-engine";

window.syncMethod = () => {
}
 document.getElementById("syncMethod").click()
    window.asyncMethod = () => {
}
 document.getElementById("asyncMethod").click()
    window.test_syncMethod = () => {

  let val = xengine.api("com.zkty.jsi.xxxx", "syncMethod", {
    title: "title",
    titleSize: 12,
  });
  document.getElementById("debug_text").innerText = typeof val + ":" + val;
}
 document.getElementById("test_syncMethod").click()
    window.test_asyncMethod = () => {

  xengine.api("com.zkty.jsi.xxxx", "asyncMethod", {
  },(val)=>{
        document.getElementById("debug_text").innerText = typeof val + ":" + val;

  });
}
 document.getElementById("test_asyncMethod").click()
    
    