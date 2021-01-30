
import localstorage from './index.js'
import xengine from "@zkty-team/x-engine-module-engine";


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

  window.removeAll = () => {
    localstorage
      .removeAll({
        isPublic: false,
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = JSON.stringify(res);
      });
  };

  window._testRemoveAllPublic = () => {
    localstorage
      .removeAll({
        isPublic: true,
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = JSON.stringify(res);
      });
  };

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

    