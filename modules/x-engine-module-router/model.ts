// 命名空间
const moduleID = "com.zkty.module.router";

interface RouterOpenAppDTO {
  //跳转类型
  type: string;
  //跳转目标
  uri: string;
  //跳转参数
  path: string;
}

//跳转页面.
function openTargetRouter(arg: RouterOpenAppDTO = { type: "0", uri:"https://www.baidu.com", path:"" }) {
  window.openTargetRouter = () => {
    router
      .openTargetRouter()
      .then((res) => { });
  };
}