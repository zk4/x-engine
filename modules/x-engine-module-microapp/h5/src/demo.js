
import microapp from './index.js'
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
    microapp
      .triggerNativeBroadCast()
  };


  window.repeatReturn__event__ = () => {
    microapp
      .repeatReturn__event__({
          __event__:function(res){
        document.getElementById("debug_text").innerText = "支持多次返回"+ JSON.stringify(res);
        return res;
          }
        }
      )
  };

  window.repeatReturn__ret__ = () => {
    microapp
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
    microapp
      .ReturnInPromiseThen()
      .then((res) => {
        document.getElementById("debug_text").innerText ="then 只支持一次性返回"+ JSON.stringify(res);
      });
  };

    window.noArgNoRet = (...args) => {
    microapp
      .noArgNoRet(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:"+res;
      });
  };


    window.noArgRetPrimitive = (...args) => {
    microapp
      .noArgRetPrimitive(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:"+res;
      });
  };

    window.noArgRetSheetDTO = (...args) => {
    microapp
      .noArgRetSheetDTO(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "title:"+res["title"];
      });
  };

    window.haveArgNoRet = (...args) => {
    microapp
      .haveArgNoRet(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:"+res;
      });
  };

    window.haveArgRetPrimitive = (...args) => {
    microapp
      .haveArgRetPrimitive(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:"+res;
      });
  };

    window.haveArgRetSheetDTO = (...args) => {
    microapp
      .haveArgRetSheetDTO({title:"abc"})
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:"+res["title"];
      });
  };

      window.anonymousType = (...args) => {
    microapp
      .anonymousType({
  age: 14,
  
})
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:"+JSON.stringify(res);
      });
  };


    