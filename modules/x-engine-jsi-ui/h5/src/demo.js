
import ui from './index.js'
import xengine from "@zkty-team/x-engine-module-engine";

window.setNavTitle = () => {

  xengine.api("com.zkty.jsi.ui", "setNavTitle", {
    title: "title",
  });
}
window.setNavBarHidden = () => {

  xengine.api("com.zkty.jsi.ui", "setNavBarHidden", {
    //是否隐藏navBar
    isHidden: true,
    //是否使用动画效果
    isAnimation: true,
  });
}
window.test_setNavBarShow = () => {

  xengine.api("com.zkty.jsi.ui", "setNavBarHidden", {
    //是否隐藏navBar
    isHidden: false,
    //是否使用动画效果
    isAnimation: true,
  });
}

    