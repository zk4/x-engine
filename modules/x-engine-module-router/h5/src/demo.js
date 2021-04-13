
import router from './index.js'
import xengine from "@zkty-team/x-engine-module-engine";

window.openTargetRouter = () => {

  window.openTargetRouter = () => {
    router
      .openTargetRouter({ type: "h5", uri:"http://192.168.10.51:8081/index.html", path:"" })
      .then((res) => { });
  };
}
 document.getElementById("openTargetRouter").click()
    window._testh5 = () => {

  window._testh5 = () => {
    router
      .openTargetRouter({ type: "h5", uri:"https://www.baidu.com", path:"" })
      .then((res) => { });
  };
}
 document.getElementById("_testh5").click()
    window._testnative = () => {

  window._testnative = () => {
    router
      .openTargetRouter({ type: "native", uri:"EntryViewController,com.zkty.demo.pedestal.MainActivity", path:"" })
      .then((res) => { });
  };
}
 document.getElementById("_testnative").click()
    window._testmicroapp = () => {

  window._testmicroapp = () => {
    router
      .openTargetRouter({ type: "microapp", uri:"com.zkty.microapp.navdemo", path:"/",version:0 })
      .then((res) => { });
  };
}
 document.getElementById("_testmicroapp").click()
    window._testmicroapp_version1 = () => {

  window._testmicroapp_version1 = () => {
    router
      .openTargetRouter({ type: "microapp", uri:"com.zkty.microapp.navdemo", path:"/",version:1 })
      .then((res) => { });
  };
}
 document.getElementById("_testmicroapp_version1").click()
    window._testmicroapp_version_not_exist = () => {

  window._testmicroapp_version_not_exist = () => {
    router
      .openTargetRouter({ type: "microapp", uri:"com.zkty.microapp.navdemo", path:"/",version:9 })
      .then((res) => { });
  };
}
 document.getElementById("_testmicroapp_version_not_exist").click()
    window._testmicroapp_path = () => {

  window._testmicroapp_path = () => {
    router
      .openTargetRouter({ type: "microapp", uri:"com.zkty.microapp.navdemo", path:"/testC",version:0 })
      .then((res) => { });
  };
}
 document.getElementById("_testmicroapp_path").click()
    window._testmicroapp_path_version1 = () => {

  window._testmicroapp_path_version1 = () => {
    router
      .openTargetRouter({ type: "microapp", uri:"com.zkty.microapp.navdemo", path:"/testC",version:1 })
      .then((res) => { });
  };
}
 document.getElementById("_testmicroapp_path_version1").click()
    window._testmicroapp_path_query = () => {

  window._testmicroapp_path_query = () => {
    router
      .openTargetRouter({ type: "microapp", uri:"com.zkty.microapp.navdemo", path:"/testC?qid=hello&b=3",version:0 })
      .then((res) => { });
  };
}
 document.getElementById("_testmicroapp_path_query").click()
    window._testuni = () => {

  window._testuni = () => {
    router
      .openTargetRouter({ type: "uni", uri:"__UNI__C002620", path:"" })
      .then((res) => { });
  };
}
 document.getElementById("_testuni").click()
    
    