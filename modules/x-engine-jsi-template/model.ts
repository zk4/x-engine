// model.ts 解析版本
const parserVersion = "1.0.0";

// 命名空间
const moduleID = "com.zkty.jsi.xxxx";
// JS模块名称
const JSModule = "@zkty-team/x-engine-jsi-xxxx";

const conf = {
  args: {},
  permissions: {
    X_USER_INFO: "READ",
    X_LBS: "READ_WRITE",
    X_PHOTO: "READ",
  },
};

interface NavTitleDTO {
  //导航条的文字
  title: string;
  //16进制的颜色色值
  titleColor: string;
  //字体大小
  titleSize: int;
}

interface NavHiddenBarDTO {
  //是否隐藏navBar
  isHidden: boolean;
  //是否使用动画效果
  isAnimation: boolean;
}

function setNavTitle(
  arg: NavTitleDTO = {titleSize: 16 }
) {
  xengine.api("com.zkty.jsi.ui", "setNavTitle", {
    title: "title",
    titleColor: "#000000"
  });
}

//使用push,或 nav 里 hideNavbar 参数控制状态的显示
function setNavBarHidden(arg: NavHiddenBarDTO) {
  xengine.api("com.zkty.jsi.ui", "setNavBarHidden", {
    //是否隐藏navBar
    isHidden: true,
    //是否使用动画效果
    isAnimation: true,
  });
}

function test_setNavBarShow(arg: NavHiddenBarDTO) {
  xengine.api("com.zkty.jsi.ui", "setNavBarHidden", {
    //是否隐藏navBar
    isHidden: false,
    //是否使用动画效果
    isAnimation: true,
  });
}

