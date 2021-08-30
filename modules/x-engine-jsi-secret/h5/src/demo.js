
import secret from './index.js'
import xengine from "@zkty-team/x-engine-core";

window.test_get = () => {

  let val = xengine.api("com.zkty.jsi.secret", "get",
    'TOKEN',
  );

  document.getElementById("debug_text").innerText = val;
  xengine.assert('test_get',val ==='I am token');
}
 document.getElementById("test_get").click()
      
    