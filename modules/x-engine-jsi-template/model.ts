// model.ts 解析版本
const parserVersion = "1.0.0";

// 命名空间
const moduleID = "com.zkty.jsi.xxxx";

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

function setNavTitle(arg: NavTitleDTO = { titleSize: 16 }) {
  xengine.api("com.zkty.jsi.xxxx", "setNavTitle", {
    title: "title",
    titleColor: "#000000",
  });
}

function setNavTitleAsyc(arg: NavTitleDTO = { titleSize: 16 }) {
  xengine.api("com.zkty.jsi.xxxx", "setNavTitleAsyc", {
    title: "title",
    titleColor: "#000000",
  },(res)=>{});
}

