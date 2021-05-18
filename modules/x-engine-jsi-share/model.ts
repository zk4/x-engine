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

// 分享
@async
function share(arg: {
  //wx_zone (朋友圈) wx_friend(好友)
  channel:string;
  //text (文字) img (图片) link (链接) miniProgram (微信小程序)
  type: string;
  //标题
  title?: string;
  //描述
  desc?: string;
  //文字内容(文字类型必填)
  text?: string;
  //图片链接 
  imgUrl?: string;
  //base64格式图片数据
  imgData?: string;
  //网页链接(链接类型必填) 
  url?: string;
  // 小程序原始id
  userName?: string; 
  // 小程序页面路径
  path? : string; 
  // 兼容低版本的网页链接
  link?: string;
  //小程序版本 0:正式版 1:开发版 2:体验版 默认为0
  miniProgramType?:int;

}): string {
  // demo code
  xengine.api(
    "com.zkty.jsi.share",
    "share",
    {
      channel: "wx_zone",
      type: "link",
      url:
        "https://www.baidu.com"
    },
    (res) => {
      document.getElementById("debug_text").innerText = JSON.stringify(res);
    }
  );

 


// 分享测试
function test_share() {
  xengine.api(
    "com.zkty.jsi.share",
    "share",
    {
      channel: "wx_zone",
      type: "link",
      url:
        "https://www.baidu.com"
	},
    (res) => {
      document.getElementById("debug_text").innerText = JSON.stringify(res);
    }
  );
}

// 分享小程序测试
function test_share2() {
  xengine.api(
    "com.zkty.jsi.share",
    "share",
    {
		channel: "wx_friend",
		type: "miniProgram",
		userName:"gh_d43f693ca31f",
		path:"/pages/media",
        title:"test",
        desc:"testdesc",
        link:"http://www.baidu.com",
        imageurl:"",
        miniProgramType:2
	},
    (res) => {
      document.getElementById("debug_text").innerText = JSON.stringify(res);
    }
  );
}

  
  
  
  
  
