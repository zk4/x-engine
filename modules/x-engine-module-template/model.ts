// 命名空间
const moduleID = "com.zkty.module.xxxx";

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

interface ContinousDTO {
  __event__?:(string)=>{}
}

interface MsgPayloadDTO{
  type: string,
  args?: Map<string,string>;
  sender?: string,
  receiver?: Array<string>,
  __event__: (string)=>void,
  __ret__: (string)=>void
}
interface CustomEvent {
  eventName: string
}
function registerEvent(args: CustomEvent={eventName:"this_is_customEvent"}){
  window.registerEvent = (...args) => {
    xengine.register(function(res){
        document.getElementById("debug_text").innerText = JSON.stringify(res);
    })
  };

}
function unregisterEvent(){
  window.unregisterEvent = () => {
    xengine.unregister()
  };
}
function triggerNativeBroadCast(){
  window.triggerNativeBroadCast = () => {
    xxxx
      .triggerNativeBroadCast()
  };

}
function repeatReturn__ret__(args:ContinousDTO):string{
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
}

function xengine_on_message(args:MsgPayloadDTO):string{
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
}

function ReturnInPromiseThen(args:ContinousDTO):string{
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
}

// 无参数无返回值
function noArgNoRet(){
    window.noArgNoRet = (...args) => {
    xxxx
      .noArgNoRet(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:"+res;
      });
  };

}

// 无参数有 primitive 返回值
function noArgRetPrimitive():string {
    window.noArgRetPrimitive = (...args) => {
    xxxx
      .noArgRetPrimitive(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:"+res;
      });
  };
}

// 无参数有返回值
function noArgRetSheetDTO():SheetDTO {
    window.noArgRetSheetDTO = (...args) => {
    xxxx
      .noArgRetSheetDTO(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "title:"+res["title"];
      });
  };
}

function haveArgNoRet(arg:SheetDTO={title:"abc"}){
    window.haveArgNoRet = (...args) => {
    xxxx
      .haveArgNoRet(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:"+res;
      });
  };
}

// have args ret primitive
function haveArgRetPrimitive(arg:SheetDTO={title:"abc"}):string {
    window.haveArgRetPrimitive = (...args) => {
    xxxx
      .haveArgRetPrimitive(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:"+res;
      });
  };
}

// have args ret Object
function haveArgRetSheetDTO(arg:SheetDTO={title:"abc"}):SheetDTO {
    window.haveArgRetSheetDTO = (...args) => {
    xxxx
      .haveArgRetSheetDTO(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:"+res["title"];
      });
  };
}


