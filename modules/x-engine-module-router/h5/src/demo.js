
import router from './index.js'

  window.openTargetRouter = () => {
    router
      .openTargetRouter({ type: "h5", uri:"https://www.baidu.com", path:"" })
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
      .openTargetRouter({ type: "microapp", uri:"com.zkty.microapp.navdemo", path:"/" })
      .then((res) => { });
  };

  window._testmicroapppath = () => {
    router
      .openTargetRouter({ type: "microapp", uri:"com.zkty.microapp.navdemo", path:"/testC" })
      .then((res) => { });
  };

  window._testuni = () => {
    router
      .openTargetRouter({ type: "uni", uri:"__UNI__C002620", path:"" })
      .then((res) => { });
  };

    
