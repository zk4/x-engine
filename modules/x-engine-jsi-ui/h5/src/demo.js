
import ui from './index.js'
import xengine from "@zkty-team/x-engine-module-engine";


  window.setNavTitle = () => {

    engine.api('com.zkty.jsi.ui','setNavTitle',{
      title: 'title'
    })

  };

  window.setNavBarHidden = () => {
  
    engine.api('com.zkty.jsi.ui','setNavBarHidden',{
      //是否隐藏navBar
      isHidden: boolean,
      //是否使用动画效果
      isAnimation: boolean
}

    })

  
    