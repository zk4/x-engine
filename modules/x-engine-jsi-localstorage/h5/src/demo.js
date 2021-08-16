
import localstorage from './index.js'
import xengine from "@zkty-team/x-engine-core";

window.test_set_abc_world = () => {

  xengine.api("com.zkty.jsi.localstorage", "set",{
    key:'abc',
    val:'world'
  });
}
window.test_get = () => {

  let val = xengine.api("com.zkty.jsi.localstorage", "get",
    'abc',
  );
  document.getElementById("debug_text").innerText = val;
}

    