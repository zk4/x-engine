
import broadcast from './index.js'
import xengine from "@zkty-team/x-engine-core";

window.test_triggerbroadcast = () => {
 {
  xengine.api('com.zkty.jsi.broadcast','triggerBroadcast',{type:'hello',payload:'world'})
}}
 document.getElementById("test_triggerbroadcast").click()
      window.test_onbroadcast = () => {
 {
  xengine.broadcastOn((type,payload)=>{
    document.getElementById("debug_text").innerText =type + payload;
  xengine.assert('test_onbroadcast',type==='hello' && payload==='world')
    
  }
)

}}
 document.getElementById("test_onbroadcast").click()
      
    