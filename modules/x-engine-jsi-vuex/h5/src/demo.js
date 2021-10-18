
import vuex from './index.js'
import xengine from "@zkty-team/x-engine-core";

window.test_set_abc_world = () => {

  xengine.api("com.zkty.jsi.vuex", "set",{
    key:'abc',
    val:'world'
  });
}
 document.getElementById("test_set_abc_world").click()
        window.test_get_abc = () => {

  xengine.api("com.zkty.jsi.vuex", "set",{
    key:'abc',
    val:'world'
  });
  let val = xengine.api("com.zkty.jsi.vuex", "get",
    'abc',
  );
    xengine.assert('test_get_abc', val==='world')
  document.getElementById("debug_text").innerText = val;
}
 document.getElementById("test_get_abc").click()
        window.test_get_empty_str = () => {

  xengine.api("com.zkty.jsi.vuex", "set",{
    key:'empty_str',
    val:''
  });
  let val = xengine.api("com.zkty.jsi.vuex", "get",
    'empty_str',
  );
    xengine.assert('test_get_empty_str', val==='')
  document.getElementById("debug_text").innerText = val;
}
 document.getElementById("test_get_empty_str").click()
        window.test_get_non_exist = () => {

  let val = xengine.api("com.zkty.jsi.vuex", "get",
    'abcafsdfdf',
  );
    xengine.assert('test_get_non_exist', val===null)
  document.getElementById("debug_text").innerText = val;
}
 document.getElementById("test_get_non_exist").click()
        window.test_set_null = () => {

  xengine.api("com.zkty.jsi.vuex", "set",{
    key:'isnull',
    val:null
  });
  let val = xengine.api("com.zkty.jsi.vuex", "get",
    'isnull',
  );
    xengine.assert('test_set_null', val===null)
  document.getElementById("debug_text").innerText = val;
}
 document.getElementById("test_set_null").click()
        
    