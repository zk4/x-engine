
import router from './index.js'
import xengine from "@zkty-team/x-engine-module-engine";


  window.openTargetRouter = () => {
    router
      .openTargetRouter({ type: "h5", uri:"http://192.168.10.51:8081/index.html", path:"" })
      .then((res) => { });
  };

  window._testh5 = () => {
    router
      .openTargetRouter({ type: "h5", uri:"https://www.baidu.com", path:"" })
      .then((res) => { });
  };

  window._testnative = () => {
    router
      .openTargetRouter({ type: "native", uri:"EntryViewController,com.zkty.demo.pedestal.MainActivity", path:"" })
      .then((res) => { });
  };

  window._testmicroapp = () => {
    router
      .openTargetRouter({ type: "microapp", uri:"com.zkty.microapp.navdemo", path:"/",version:0 })
      .then((res) => { });
  };

  window._testmicroapp_version1 = () => {
    router
      .openTargetRouter({ type: "microapp", uri:"com.zkty.microapp.navdemo", path:"/",version:1 })
      .then((res) => { });
  };

  window._testmicroapp_version_not_exist = () => {
    router
      .openTargetRouter({ type: "microapp", uri:"com.zkty.microapp.navdemo", path:"/",version:9 })
      .then((res) => { });
  };

  window._testmicroapp_path = () => {
    router
      .openTargetRouter({ type: "microapp", uri:"com.zkty.microapp.navdemo", path:"/testC",version:0 })
      .then((res) => { });
  };

  window._testmicroapp_path_version1 = () => {
    router
      .openTargetRouter({ type: "microapp", uri:"com.zkty.microapp.navdemo", path:"/testC",version:1 })
      .then((res) => { });
  };

  window._testmicroapp_path_query = () => {
    router
      .openTargetRouter({ type: "microapp", uri:"com.zkty.microapp.navdemo", path:"/testC?qid=hello&b=3",version:0 })
      .then((res) => { });
  };

  window._testuni = () => {
    router
      .openTargetRouter({ type: "uni", uri:"__UNI__C002620", path:"" })
      .then((res) => { });
  };

    