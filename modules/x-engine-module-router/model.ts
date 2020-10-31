// 命名空间
const moduleID = "com.zkty.module.router";

interface RouterOpenAppDTO {
  //跳转类型
  type: string;
  //跳转目标
  uri: string;
  //跳转参数
  path: string;
  //其他参数
  args?:Map<string, string>;
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
      .openTargetRouter({ type: "microapp", uri:"com.zkty.microapp.navdemo", path:"" })
      .then((res) => { });
  };
}
function _testuni(arg: RouterOpenAppDTO) {
  window._testuni = () => {
    router
      .openTargetRouter({ type: "uni", uri:"__UNI__C002620", path:"" })
      .then((res) => { });
  };
}
