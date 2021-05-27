
import localstorage from './index.js'
import xengine from "@zkty-team/x-engine-module-engine";

window.set = () => {

  window.set = () => {
    localstorage
      .set({
        key: "key",
        value: "value",
        isPublic: false,
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = JSON.stringify(res);
      });
  };
}
 document.getElementById("set").click()
    window.get = () => {

  window.get = () => {
    localstorage
      .get({
        key: "key",
        isPublic: false,
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = JSON.stringify(res);
      });
  };
}
 document.getElementById("get").click()
    window.remove = () => {

  window.remove = () => {
    localstorage
      .remove({
        key: "key",
        isPublic: false,
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = JSON.stringify(res);
      });
  };
}
 document.getElementById("remove").click()
    window.removeAll = () => {

  window.removeAll = () => {
    localstorage
      .removeAll({
        isPublic: false,
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = JSON.stringify(res);
      });
  };
}
 document.getElementById("removeAll").click()
    window._testRemoveAllPublic = () => {

  window._testRemoveAllPublic = () => {
    localstorage
      .removeAll({
        isPublic: true,
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = JSON.stringify(res);
      });
  };
}
 document.getElementById("_testRemoveAllPublic").click()
    window._testSetPublicStorage = () => {

  window._testSetPublicStorage = () => {
    localstorage
      .set({
        key: "key",
        value: "public value",
        isPublic: true,
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = JSON.stringify(res);
      });
  };
}
 document.getElementById("_testSetPublicStorage").click()
    window._testGetPublicStorage = () => {

  window._testGetPublicStorage = () => {
    localstorage
      .get({
        key: "LLBOrigin",
        isPublic: true,
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = JSON.stringify(res);
      });
  };
}
 document.getElementById("_testGetPublicStorage").click()
    window._testSetLocalStorage = () => {

  window._testSetLocalStorage = () => {
    localstorage
      .set({
        key: "key",
        value: "local value",
        isPublic: false,
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = JSON.stringify(res);
      });
  };
}
 document.getElementById("_testSetLocalStorage").click()
    window._testGetLocalStorage = () => {

  window._testGetLocalStorage = () => {
    localstorage
      .get({
        key: "key",
        isPublic: false,
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = JSON.stringify(res);
      });
  };
}
 document.getElementById("_testGetLocalStorage").click()
    
    