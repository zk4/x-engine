
import open from './index.js'
import xengine from "@zkty-team/x-engine-module-engine";


  window.broadcastOn = (...args) => {
    xengine.broadcastOn(function (res) {
      document.getElementById("debug_text").innerText = JSON.stringify(res);
    });
  };

  window.broadcastOff = () => {
    xengine.broadcastOff();
  };

  window.triggerNativeBroadCast = () => {
    open.triggerNativeBroadCast();
  };

  window.repeatReturn__event__ = () => {
    open.repeatReturn__event__({
      __event__: function (res) {
        document.getElementById("debug_text").innerText =
          "支持多次返回" + JSON.stringify(res);
        return res;
      },
    });
  };

  window.repeatReturn__ret__ = () => {
    open.repeatReturn__ret__({
      __ret__: function (res) {
        document.getElementById("debug_text").innerText =
          "支持多次返回" + JSON.stringify("__ret__:" + res);
        return res;
      },
    });
  };

  window.ReturnInPromiseThen = () => {
    open.ReturnInPromiseThen().then((res) => {
      document.getElementById("debug_text").innerText =
        "then 只支持一次性返回" + JSON.stringify(res);
    });
  };

  window.noArgNoRet = (...args) => {
    open.noArgNoRet(...args).then((res) => {
      document.getElementById("debug_text").innerText = "ret:" + res;
    });
  };

  window.noArgRetPrimitive = (...args) => {
    open.noArgRetPrimitive(...args).then((res) => {
      document.getElementById("debug_text").innerText = "ret:" + res;
    });
  };

  window.noArgRetSheetDTO = (...args) => {
    open.noArgRetSheetDTO(...args).then((res) => {
      document.getElementById("debug_text").innerText = "title:" + res["title"];
    });
  };

  window.haveArgNoRet = (...args) => {
    open.haveArgNoRet(...args).then((res) => {
      document.getElementById("debug_text").innerText = "ret:" + res;
    });
  };

  window.haveArgRetPrimitive = (...args) => {
    open.haveArgRetPrimitive(...args).then((res) => {
      document.getElementById("debug_text").innerText = "ret:" + res;
    });
  };

  window.haveArgRetSheetDTO = (...args) => {
    open.haveArgRetSheetDTO({ title: "abc" }).then((res) => {
      document.getElementById("debug_text").innerText = "ret:" + res["title"];
    });
  };

  window.anonymousType = (...args) => {
    open
      .anonymousType({
        age: 14,
      })
      .then((res) => {
        document.getElementById("debug_text").innerText =
          "ret:" + JSON.stringify(res);
      });
  };

    