
import direct_manager from './index.js'
import xengine from "@zkty-team/x-engine-module-engine";


  window.push = () => {
   engine.api('com.zkty.jsi.direct','push',{
    scheme: 'omp',
    host: "10.2.128.80:8082",
    pathname:'/'
  })
  }

  window.back = () => {
    engine.api('com.zkty.jsi.direct','back',{
     scheme: 'omp',
     path:'-1'
   }
   }

    