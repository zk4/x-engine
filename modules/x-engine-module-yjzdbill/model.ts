// 命名空间
const moduleID = "com.zkty.module.yjzdbill";

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
function broadcastOn(){
  window.broadcastOn = (...args) => {
    xengine.broadcastOn(function(res){
        document.getElementById("debug_text").innerText = JSON.stringify(res);
    })
  };
}
function broadcastOff(){
  window.broadcastOff = () => {
    xengine.broadcastOff()
  };
}
function triggerNativeBroadCast(){
  window.triggerNativeBroadCast = () => {
    yjzdbill
      .triggerNativeBroadCast()
  };

}
function repeatReturn__event__(args:ContinousDTO):string{
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
}
function repeatReturn__ret__(args:ContinousDTO):string{
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
}


function ReturnInPromiseThen(args:ContinousDTO):string{
  window.ReturnInPromiseThen = () => {
    yjzdbill
      .ReturnInPromiseThen()
      .then((res) => {
        document.getElementById("debug_text").innerText ="then 只支持一次性返回"+ JSON.stringify(res);
      });
  };
}

// 无参数无返回值
function noArgNoRet(){
    window.noArgNoRet = (...args) => {
    yjzdbill
      .noArgNoRet(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:"+res;
      });
  };

}

// 无参数有 primitive 返回值
function noArgRetPrimitive():string {
    window.noArgRetPrimitive = (...args) => {
    yjzdbill
      .noArgRetPrimitive(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:"+res;
      });
  };
}

// 无参数有返回值
function noArgRetSheetDTO():SheetDTO {
    window.noArgRetSheetDTO = (...args) => {
    yjzdbill
      .noArgRetSheetDTO(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "title:"+res["title"];
      });
  };
}

function haveArgNoRet(arg:SheetDTO={title:"abc"}){
    window.haveArgNoRet = (...args) => {
    yjzdbill
      .haveArgNoRet(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:"+res;
      });
  };
}

// have args ret primitive
function haveArgRetPrimitive(arg:SheetDTO={title:"abc"}):string {
    window.haveArgRetPrimitive = (...args) => {
    yjzdbill
      .haveArgRetPrimitive(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:"+res;
      });
  };
}

// have args ret Object
function haveArgRetSheetDTO(arg:SheetDTO={title:"abc"}):SheetDTO {
    window.haveArgRetSheetDTO = (...args) => {
    yjzdbill
      .haveArgRetSheetDTO(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:"+res["title"];
      });
  };
}

