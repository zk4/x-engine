
import phone from './index.js'

    window.noArgNoRet = (...args) => {
    phone
      .noArgNoRet(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:"+res;
      });
  };


    window.noArgRetPrimitive = (...args) => {
    phone
      .noArgRetPrimitive(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:"+res;
      });
  };

    window.noArgRetSheetDTO = (...args) => {
    phone
      .noArgRetSheetDTO(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "title:"+res["title"];
      });
  };

    window.haveArgNoRet = (...args) => {
    phone
      .haveArgNoRet(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:"+res;
      });
  };

    window.haveArgRetPrimitive = (...args) => {
    phone
      .haveArgRetPrimitive(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:"+res;
      });
  };

    window.haveArgRetSheetDTO = (...args) => {
    phone
      .haveArgRetSheetDTO(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:"+res["title"];
      });
  };

  window.showActionSheet = (...args) => {
    phone
      .showActionSheet({
        title: "hello",
        itemList: ["hello", "world", "he"],
        content: "content",
        __event__: (res) => {
          document.getElementById("debug_text").innerText = res;
        },
        ...args
      })
      .then((res) => {
        //document.getElementById("debug_text").innerText = res;
      });
  };

    window.testHelloButton=()=>{
      phone.showActionSheet(
      	{title:"title",itemList:["a","b","c"],content:"content"}
      )
      .then(res=>{
        document.getElementById("debug_text").innerText= res;
      })
    }


    