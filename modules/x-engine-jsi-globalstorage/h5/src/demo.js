
import globalstorage from './index.js'
import xengine from "@zkty-team/x-engine-core";

window.test_set_abc_world = () => {

  xengine.api("com.zkty.jsi.globalstorage", "set",{
    key:'abc',
    val:'world'
  });
}
 document.getElementById("test_set_abc_world").click()
        window.test_get_abc = () => {

  let val = xengine.api("com.zkty.jsi.globalstorage", "get",
    'abc',
  );
  xengine.assert('test_get_abc', val==='world')
  document.getElementById("debug_text").innerText = val;
}
 document.getElementById("test_get_abc").click()
        window.test_del_abc = () => {

  xengine.api("com.zkty.jsi.globalstorage", "del",
    'abc',
  );
 
}
 document.getElementById("test_del_abc").click()
        window.test_2_get_abc = () => {

  let val = xengine.api("com.zkty.jsi.globalstorage", "get",
    'abc',
  );
  xengine.assert('test_2_get_abc', val===null)
  document.getElementById("debug_text").innerText = val;
}
 document.getElementById("test_2_get_abc").click()
        
    