
import ui from './index.js'
import xengine from "@zkty-team/x-engine-module-engine";

window.setNavTitle = () => {
  xengine.api("com.zkty.jsi.ui", "setNavTitle", {
    title: "title",
    titleColor: "#000000"
  });
}

window.setNavBarHidden = () => {
  xengine.api("com.zkty.jsi.ui", "setNavBarHidden", {
    isHidden: true,
    isAnimation: true,
  });
}
    