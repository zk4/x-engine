
import broadcast from './index.js'
import xengine from "@zkty-team/x-engine-core";

window.test_triggerNativeBroadcastNull = () => {

  xengine.api('com.zkty.jsi.broadcast', 'triggerNativeBroadcastNull')

}
 document.getElementById("test_triggerNativeBroadcastNull").click()
        window.test_ontriggerNativeBroadcastNull = () => {

  xengine.broadcastOn((type, payload) => {
    if (type === 'native_null') {
      console.log(type, payload)
      document.getElementById("debug_text").innerText = type + payload;
      xengine.assert('test_ontriggerNativeBroadcastNull', payload === null )
    }

  })
}
 document.getElementById("test_ontriggerNativeBroadcastNull").click()
        window.test_triggerbroadcast = () => {

  xengine.api('com.zkty.jsi.broadcast', 'triggerBroadcast', {type: 'hello', payload: 'world'})
}
 document.getElementById("test_triggerbroadcast").click()
        window.test_onbroadcast = () => {

  xengine.broadcastOn((type, payload) => {
    if (type === 'hello') {
      document.getElementById("debug_text").innerText = type + payload;
      xengine.assert('test_onbroadcast', type === 'hello' && payload === 'world')
    }
  })
}
 document.getElementById("test_onbroadcast").click()
        window.test_triggerbroadcast_null = () => {

  xengine.api('com.zkty.jsi.broadcast', 'triggerBroadcast', {type: 'isnull', payload: null})
}
 document.getElementById("test_triggerbroadcast_null").click()
        window.test_onbroadcast_null = () => {

  xengine.broadcastOn((type, payload) => {
    if (type === 'isnull') {
      console.log(type, payload)
      document.getElementById("debug_text").innerText = type + payload;
      xengine.assert('test_onbroadcast_null', false )
    }

  })
        xengine.assert('test_onbroadcast_null', true )

}
 document.getElementById("test_onbroadcast_null").click()
        
    