
import localstorage from './index.js'

  window.setLocalStorage = () => {
    localstorage.setLocalStorage({
      key: "key",
      value: "value"
    })
      .then((res) => {
        document.getElementById("debug_text").innerText = res.result;
      });
  };

  window.getLocalStorage = () => {
    localstorage.getLocalStorage({
      key: "key",
      isPublic: false,
    })
      .then((res) => {
        document.getElementById("debug_text").innerText = res.result;
      });
  };

  window.removeLocalStorageItem = () => {
    localstorage.removeLocalStorageItem({
      key: "item",
    })
      .then((res) => {
        document.getElementById("debug_text").innerText = res.result;
      });
  };

  window.removeLocalStorageAll = () => {
    localstorage.removeLocalStorageAll({
      key: "all",
    }).then((res) => {
      document.getElementById("debug_text").innerText = res.result;
    });
  };

  window._testSetOtherIDLocalStorage = () => {
    localstorage._testSetOtherIDLocalStorage({
      key: "key",
      value: "value2222",
      isPublic: false,
    })
      .then((res) => {
        document.getElementById("debug_text").innerText = res.result;
      });
  };

  window._testGetOtherIDLocalStorage = () => {
    localstorage._testGetOtherIDLocalStorage({
      key: "key",
      isPublic: false,
    })
      .then((res) => {
        document.getElementById("debug_text").innerText = res.result;
      });
  };

    