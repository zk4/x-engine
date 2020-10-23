// 命名空间
const moduleID = "com.zkty.module.lope";

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

function openDoor(){
  window.openDoor = (...args) => {
  lope
    .openDoor(...args)
    .then((res) => {
      document.getElementById("debug_text").innerText = "ret:"+res;
    });
  };

}

function customOpenDoor(){
  window.customOpenDoor = (...args) => {
  lope
    .customOpenDoor(...args)
    .then((res) => {
      document.getElementById("debug_text").innerText = "ret:"+res;
    });
  };

}

function lightLift(){
  window.lightLift = (...args) => {
  lope
    .lightLift(...args)
    .then((res) => {
      document.getElementById("debug_text").innerText = "ret:"+res;
    });
  };

}

