
import store from './index.js'
import xengine from "@zkty-team/x-engine-core";

window.test_getObject = () => {

    xengine.api("com.zkty.jsi.store", "get", { key: "obj" }, (val) => {
      document.getElementById("debug_text").innerText = typeof val + ":" + val;
    });
  }
 document.getElementById("test_getObject").click()
      window.test_setObject = () => {

    xengine.api(
      "com.zkty.jsi.store",
      "set",
      {
        key: "obj",
        val: JSON.stringify({ key: { a: "a", b: [1, 2, 3], c: { d: "d" } } }),
      },
      (res) => {
        console.log(res);
      }
    );
  }
 document.getElementById("test_setObject").click()
      
    