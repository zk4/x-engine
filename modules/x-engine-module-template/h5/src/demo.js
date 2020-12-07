
import xxxx from './index.js'

  window.xengine_on_message = () => {
    xxxx
      .xengine_on_message({
          __ret__:function(res){
        document.getElementById("debug_text").innerText = JSON.stringify("__ret__:"+res);
          },
          __event__:function(res){
        document.getElementById("debug_text").innerText = JSON.stringify(res);
          }
        }
      )
  };

  window.repeatReturn__ret__ = () => {
    xxxx
      .repeatReturn__ret__({
          __ret__:function(res){
        document.getElementById("debug_text").innerText = JSON.stringify("__ret__:"+res);
        return res;
          },
          __event__:function(res){
        document.getElementById("debug_text").innerText = JSON.stringify(res);
        return res;
          }
        }
      )
  };

  window.ReturnInPromiseThen = () => {
    xxxx
      .ReturnInPromiseThen({
          __event__:function(res){
        document.getElementById("debug_text").innerText = JSON.stringify(res);
          }
        }
      )
      .then((res) => {
        document.getElementById("debug_text").innerText = JSON.stringify(res);
      });
  };

    window.noArgNoRet = (...args) => {
    xxxx
      .noArgNoRet(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:"+res;
      });
  };


    window.noArgRetPrimitive = (...args) => {
    xxxx
      .noArgRetPrimitive(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:"+res;
      });
  };

    window.noArgRetSheetDTO = (...args) => {
    xxxx
      .noArgRetSheetDTO(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "title:"+res["title"];
      });
  };

    window.haveArgNoRet = (...args) => {
    xxxx
      .haveArgNoRet(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:"+res;
      });
  };

    window.haveArgRetPrimitive = (...args) => {
    xxxx
      .haveArgRetPrimitive(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:"+res;
      });
  };

    window.haveArgRetSheetDTO = (...args) => {
    xxxx
      .haveArgRetSheetDTO(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:"+res["title"];
      });
  };

    