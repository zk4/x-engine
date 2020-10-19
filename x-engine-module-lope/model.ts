// 命名空间
const moduleID = "com.zkty.module.lope";

// dto
interface serviceUUIDDTO {
  serviceUUID: Array<string>;
  
}

function openDoor(serviceUUIDDTO: serviceUUIDDTO = {
  serviceUUID: ["2560","FEE7"],
}) {
    window.openDoor = () => {
    lope
      .openDoor()
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:"+res["title"];
      });
  };
}

function customOpenDoor(){
  window.customOpenDoor = () => {
  lope
    .customOpenDoor()
    .then((res) => {
      document.getElementById("debug_text").innerText = "ret:"+res;
    });
  };

}

function lightLift(){
  window.lightLift = () => {
  lope
    .lightLift()
    .then((res) => {
      document.getElementById("debug_text").innerText = "ret:"+res;
    });
  };

}

// have args ret primitive
function haveArgRetPrimitive(arg:SheetDTO={title:"abc"}):string {
    window.haveArgRetPrimitive = (...args) => {
    lope
      .haveArgRetPrimitive(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:"+res;
      });
  };
}



