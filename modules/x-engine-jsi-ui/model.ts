// model.ts 解析版本
const parserVersion = "1.0.0";

// 命名空间
const moduleID = "com.zkty.jsi.ui";
// JS模块名称
const JSModule = "@zkty-team/x-engine-jsi-ui";

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
  arg: NavTitleDTO = {titleColor: "#000000", titleSize: 16 }
) {
  window.setNavTitle = () => {

    engine.api('com.zkty.jsi.ui','setNavTitle',{
      title: 'title'
    })

  };
}



//使用push,或 nav 里 hideNavbar 参数控制状态的显示
function setNavBarHidden(arg:NavHiddenBarDTO){
  window.setNavBarHidden = () => {
  
    engine.api('com.zkty.jsi.ui','setNavBarHidden',{
      //是否隐藏navBar
      isHidden: boolean,
      //是否使用动画效果
      isAnimation: boolean
}

    })

  };
}
