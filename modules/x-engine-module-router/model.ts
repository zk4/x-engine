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

  version?: int;

  // 是否隐藏navbar, 默认 false
  hideNavbar?: Boolean;
}

//跳转页面.
function openTargetRouter(arg: RouterOpenAppDTO = { type: "h5", uri:"http://192.168.10.51:8081/index.html", path:"" ,hideNavbar:false}) {
  window.openTargetRouter = () => {
    router
      .openTargetRouter({ type: "h5", uri:"http://192.168.10.51:8081/index.html", path:"" })
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
      .openTargetRouter({ type: "microapp", uri:"com.zkty.microapp.navdemo", path:"/",version:0 })
      .then((res) => { });
  };
}
//跳转native页面.
function _testmicroapp_version1(arg: RouterOpenAppDTO) {
  window._testmicroapp_version1 = () => {
    router
      .openTargetRouter({ type: "microapp", uri:"com.zkty.microapp.navdemo", path:"/",version:1 })
      .then((res) => { });
  };
}

//跳转native页面.
function _testmicroapp_version_not_exist(arg: RouterOpenAppDTO) {
  window._testmicroapp_version_not_exist = () => {
    router
      .openTargetRouter({ type: "microapp", uri:"com.zkty.microapp.navdemo", path:"/",version:9 })
      .then((res) => { });
  };
}

//跳转native页面.
function _testmicroapp_path(arg: RouterOpenAppDTO) {
  window._testmicroapp_path = () => {
    router
      .openTargetRouter({ type: "microapp", uri:"com.zkty.microapp.navdemo", path:"/testC",version:0 })
      .then((res) => { });
  };
}

//跳转native页面.
function _testmicroapp_path_version1(arg: RouterOpenAppDTO) {
  window._testmicroapp_path_version1 = () => {
    router
      .openTargetRouter({ type: "microapp", uri:"com.zkty.microapp.navdemo", path:"/testC",version:1 })
      .then((res) => { });
  };
}

function _testmicroapp_path_query(arg: RouterOpenAppDTO) {
  window._testmicroapp_path_query = () => {
    router
      .openTargetRouter({ type: "microapp", uri:"com.zkty.microapp.navdemo", path:"/testC?qid=hello&b=3",version:0 })
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
