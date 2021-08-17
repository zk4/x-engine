
import ui from './index.js'
import xengine from "@zkty-team/x-engine-core";

window.test_setNavBarShow = () => {

  xengine.api("com.zkty.jsi.ui", "setNavBarHidden", {
    //是否隐藏navBar
    isHidden: false,
    //是否使用动画效果
    isAnimation: true,
  });
}
 document.getElementById("test_setNavBarShow").click()
        
    