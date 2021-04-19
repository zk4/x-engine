
import store from './index.js'
import xengine from "@zkty-team/x-engine-core";

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
      window.test_getObject = () => {

  xengine.api("com.zkty.jsi.store", "get", { key: "obj" }, (val) => {
    document.getElementById("debug_text").innerText = typeof val + ":" + val;
  });
}
 document.getElementById("test_getObject").click()
      window.test_setObject_sync = () => {

  xengine.api("com.zkty.jsi.store", "set", {
    key: "obj",
    val: JSON.stringify({ key: { a: "a", b: [1, 2, 3], c: { d: "d" } } }),
  });
}
 document.getElementById("test_setObject_sync").click()
      window.test_getObject_sync = () => {

  let val = xengine.api("com.zkty.jsi.store", "get", { key: "obj" });
  document.getElementById("debug_text").innerText = typeof val + ":" + val;
}
 document.getElementById("test_getObject_sync").click()
      window.test_setNil = () => {

  xengine.api(
    "com.zkty.jsi.store",
    "set",
    {
      key: "nil",
      val: null,
    },
    (res) => {}
  );
}
 document.getElementById("test_setNil").click()
      window.test_getNil = () => {

  xengine.api("com.zkty.jsi.store", "get", { key: "nil" }, (val) => {
    if (!res) {
      document.getElementById("debug_text").innerText = "为 nil";
    }
  });
}
 document.getElementById("test_getNil").click()
      window.test_setAssertChangeColor = () => {

  xengine.api(
    "com.zkty.jsi.store",
    "set",
    {
      key: "str",
      val: "hello",
    },
    (res) => {}
  );
}
 document.getElementById("test_setAssertChangeColor").click()
      window.test_getAssertTrue = () => {

  xengine.api("com.zkty.jsi.store", "get", { key: "str" }, (val) => {
    xengine.assert('test_getAssertTrue',val === 'hello')
    document.getElementById("debug_text").innerText = "为 nil";
  });
}
 document.getElementById("test_getAssertTrue").click()
      
    