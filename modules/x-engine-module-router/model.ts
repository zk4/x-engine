// 命名空间
const moduleID = "com.zkty.module.router";

interface RouterOpenAppDTO {
  //跳转类型
  type: string;
  //跳转目标
  uri: string;
  //(url链接)，maxlength(1024)
  fallback?: string;
  //跳转参数
  path: string;
  // 如果是 microapp, version 代表版本号
  version?: int;
  // 保留字段
  args?: Map<string,string>;
}

//跳转页面.
function openTargetRouter(arg: RouterOpenAppDTO = { type: "h5", uri:"https://www.baidu.com", path:"" }) {
  window.openTargetRouter = () => {
    router
      .openTargetRouter({ type: "h5", uri:"https://www.baidu.com", path:"" })
      .then((res) => { });
  };
}

//跳转h5页面.
function _testh5(arg: RouterOpenAppDTO  ) {
  window._testh5 = () => {
    router
      .openTargetRouter({ type: "h5", uri:"https://www.baidu.com", path:"" })
      .then((res) => { });
  };
}

//跳转native页面.
function _testnative(arg: RouterOpenAppDTO  ) {
  window._testnative = () => {
    router
      .openTargetRouter({ type: "native", uri:"EntryViewController,com.zkty.demo.pedestal.MainActivity", path:"" })
      .then((res) => { });
  };
}

//跳转native页面.
function _testmicroapp(arg: RouterOpenAppDTO) {
  window._testmicroapp = () => {
    router
      .openTargetRouter({ type: "microapp", uri:"com.zkty.microapp.navdemo",version:0, path:"" })
      .then((res) => { });
  };
}
