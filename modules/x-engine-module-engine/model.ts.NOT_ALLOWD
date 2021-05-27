// 命名空间
const moduleID = "com.zkty.module.container";

// dto
interface XEContainerDTO {
  // microAppid
  microAppId: string;
  // routerPath
  routePath: string;
  // direction 0:left->right    1: down->up
  direction: int;
}


function push(arg:XEContainerDTO={direction:0}){
    window.push = (...args) => {
    container
      .push(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:"+res;
      });
  };
}
