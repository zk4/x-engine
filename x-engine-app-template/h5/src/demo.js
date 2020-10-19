
import demo from './index.js'
{
    window.noArgNoRet = (...args) => {
    demo
      .noArgNoRet(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:"+res;
      });
  };

} {
    window.noArgRetPrimitive = (...args) => {
    demo
      .noArgRetPrimitive(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:"+res;
      });
  };
} {
    window.noArgRetSheetDTO = (...args) => {
    demo
      .noArgRetSheetDTO(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "title:"+res["title"];
      });
  };
}{
    window.haveArgNoRet = (...args) => {
    demo
      .haveArgNoRet(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:"+res;
      });
  };
} {
    window.haveArgRetPrimitive = (...args) => {
    demo
      .haveArgRetPrimitive(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:"+res;
      });
  };
} {
    window.haveArgRetSheetDTO = (...args) => {
    demo
      .haveArgRetSheetDTO(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:"+res["title"];
      });
  };
}{
  window.showActionSheet = (...args) => {
    demo
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
}{
    window.testHelloButton=(...args)=>{
      demo.showActionSheet(
      	{title:"title",itemList:["a","b","c"],content:"content"}
      )
      .then(res=>{
        document.getElementById("debug_text").innerText= res;
      })
    }

}
    
