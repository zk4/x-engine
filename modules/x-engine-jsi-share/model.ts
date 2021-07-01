// model.ts 解析版本
const parserVersion = "1.0.0";

// 命名空间
const moduleID = "com.zkty.jsi.share";

const conf = {
  args: {},
  permissions: {
    X_USER_INFO: "READ",
    X_LBS: "READ_WRITE",
    X_PHOTO: "READ",
  },
};

interface ShareDTO {
  // 当前可用:
  // 1. wx_friend 微信联系人
  // 2. wx_zone 微信朋友圈
  channel: string;

  // 当前可用：
  // 1. text 文字
  // 2. img 图片
  // 3. link 链接
  // 4. miniProgram 微信小程序
  type: string;

  // 相应分享信息
  info: Map<string, string>;
}

interface ShareTextDTO {
  //文字内容
  text: string;
}

interface ShareImgDTO {
  // 图片的网络路径或base64格式图片数据
  // 对应图片内容大小不超过 10MB
  imgData: string;
}

interface ShareLinkDTO {
  //标题
  title: string;
  //描述
  desc: string;

  //缩略图链接
  imgUrl?: string;

  //网页链接，限制长度不超过 10KB
  url: string;
}

interface ShareMiniProgramDTO {
  // 小程序原始id
  userName: string;
  // 小程序页面路径
  path: string;
  // 兼容低版本的网页链接
  link: string;
  //小程序版本 0:正式版 1:开发版 2:体验版 默认为0
  miniProgramType: int;
  //标题
  title: string;
  //描述
  desc: string;
  //封面图片链接
  imgUrl: string;
}

// 分享
function share(arg: ShareDTO) {
  // 分享链接
  xengine.api("com.zkty.jsi.share", "share", {
    channel: "wx_zone",
    type: "link",
    info: {
      url: "https://www.baidu.com",
      title: "testTitle",
      desc: "description",
    },
  });

  // 分享小程序
  xengine.api("com.zkty.jsi.share", "share", {
    channel: "wx_friend",
    type: "miniProgram",
    info: {
      userName: "gh_d43f693ca31f",
      path: "/pages/media",
      title: "test",
      desc: "testdesc",
      link: "http://www.baidu.com",
      imageurl: "",
      miniProgramType: 2,
    },
  });

  // 分享图片
  xengine.api("com.zkty.jsi.share", "share", {
    channel: "wx_zone",
    type: "img",
    info: {
      imgData: "https://www.baidu.com",
    },
  });
}

// 分享测试
function test_share() {
  xengine.api("com.zkty.jsi.share", "share", {
    channel: "wx_zone",
    type: "link",
    info: {
      url: "https://www.baidu.com",
      title: "testTitle",
      desc: "description",
    },
  });
}

// 分享小程序测试
function test_share2() {
  xengine.api("com.zkty.jsi.share", "share", {
    channel: "wx_friend",
    type: "miniProgram",
    info: {
      userName: "gh_d43f693ca31f",
      path: "/pages/media",
      title: "test",
      desc: "testdesc",
      link: "http://www.baidu.com",
      imageurl: "",
      miniProgramType: 2,
    },
  });
}
