
import yjzdbill from './index.js'
import xengine from "@zkty-team/x-engine-module-engine";


  window.broadcastOn = (...args) => {
    xengine.broadcastOn(function(res){
        document.getElementById("debug_text").innerText = JSON.stringify(res);
    })
  };

  window.broadcastOff = () => {
    xengine.broadcastOff()
  };

  window.triggerNativeBroadCast = () => {
    yjzdbill
      .triggerNativeBroadCast()
  };


  window.repeatReturn__event__ = () => {
    yjzdbill
      .repeatReturn__event__({
          __event__:function(res){
        document.getElementById("debug_text").innerText = "支持多次返回"+ JSON.stringify(res);
        return res;
          }
        }
      )
  };

  window.repeatReturn__ret__ = () => {
    yjzdbill
      .repeatReturn__ret__(
        {
          __ret__:function(res){
        document.getElementById("debug_text").innerText = "支持多次返回"+ JSON.stringify("__ret__:"+res);
        return res;
          },
        }
      )
  };

  window.ReturnInPromiseThen = () => {
    yjzdbill
      .ReturnInPromiseThen()
      .then((res) => {
        document.getElementById("debug_text").innerText ="then 只支持一次性返回"+ JSON.stringify(res);
      });
  };

    window.noArgNoRet = (...args) => {
    yjzdbill
      .noArgNoRet(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:"+res;
      });
  };


    window.noArgRetPrimitive = (...args) => {
    yjzdbill
      .noArgRetPrimitive(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:"+res;
      });
  };

    window.noArgRetSheetDTO = (...args) => {
    yjzdbill
      .noArgRetSheetDTO(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "title:"+res["title"];
      });
  };

    window.haveArgNoRet = (...args) => {
    yjzdbill
      .haveArgNoRet(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:"+res;
      });
  };

    window.haveArgRetPrimitive = (...args) => {
    yjzdbill
      .haveArgRetPrimitive(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:"+res;
      });
  };

    window.haveArgRetSheetDTO = (...args) => {
    yjzdbill
      .haveArgRetSheetDTO(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:"+res["title"];
      });
  };

    