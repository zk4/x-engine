// 命名空间
const moduleID = "com.zkty.module.demo";

// dto
interface SheetDTO {
  // 标题
  title: string;
  // 子标题?
  itemList?: Array<string>;
  // 内容
  content?: string;
  // 点击子标题回调函数
  __event__: (index:string)=>void,
}

// 无参数无返回值
function noArgNoRet(){
    window.noArgNoRet = (...args) => {
    demo
      .noArgNoRet(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:"+res;
      });
  };

}

// 无参数有 primitive 返回值
function noArgRetPrimitive():string {
    window.noArgRetPrimitive = (...args) => {
    demo
      .noArgRetPrimitive(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:"+res;
      });
  };
}

// 无参数有返回值
function noArgRetSheetDTO():SheetDTO {
    window.noArgRetSheetDTO = (...args) => {
    demo
      .noArgRetSheetDTO(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "title:"+res["title"];
      });
  };
}

function haveArgNoRet(arg:SheetDTO={title:"abc"}){
    window.haveArgNoRet = (...args) => {
    demo
      .haveArgNoRet(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:"+res;
      });
  };
}

// have args ret primitive
function haveArgRetPrimitive(arg:SheetDTO={title:"abc"}):string {
    window.haveArgRetPrimitive = (...args) => {
    demo
      .haveArgRetPrimitive(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:"+res;
      });
  };
}

// have args ret Object
function haveArgRetSheetDTO(arg:SheetDTO={title:"abc"}):SheetDTO {
    window.haveArgRetSheetDTO = (...args) => {
    demo
      .haveArgRetSheetDTO(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:"+res["title"];
      });
  };
}


/*
系统弹出框： 

**demo** 
``` js 
ui.showActionSheet({
    title: "hello",
    itemList: ["a", "b", "c"],
    content: "content",
    __event__: null,
  })
```
*/
function showActionSheet(
  sheetDTO: SheetDTO = {
    title: "hello",
    itemList: ["hello", "world", "he"],
    content: "content",
    __event__: null,
  }
){
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
}

function testHelloButton(){
    window.testHelloButton=()=>{
      demo.showActionSheet(
      	sheetDTO:SheetDTO={title:"title",itemList:["a","b","c"],content:"content"}
      )
      .then(res=>{
        document.getElementById("debug_text").innerText= res;
      })
    }

}
