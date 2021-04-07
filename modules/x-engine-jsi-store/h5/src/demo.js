
import store from './index.js'
import xengine from "@zkty-team/x-engine-module-engine";

window.get = () => {
}
window.set = () => {
}
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
window.test_getObject = () => {

  xengine.api("com.zkty.jsi.store", "get", { key: "obj" }, (val) => {
    document.getElementById("debug_text").innerText = typeof val + ":" + val;
  });
}
window.test_setObject_sync = () => {

  xengine.api("com.zkty.jsi.store", "set", {
    key: "obj",
    val: JSON.stringify({ key: { a: "a", b: [1, 2, 3], c: { d: "d" } } }),
  });
}
window.test_getObject_sync = () => {

  let val = xengine.api("com.zkty.jsi.store", "get", { key: "obj" });
  document.getElementById("debug_text").innerText = typeof val + ":" + val;
}
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
window.test_getNil = () => {

  xengine.api("com.zkty.jsi.store", "get", { key: "nil" }, (val) => {
    if (!res) {
      document.getElementById("debug_text").innerText = "为 nil";
    }
  });
}

    