





JSI Id: com.zkty.jsi.share

version: 3.0.3



## share
[`async`](/docs/modules/模块-规范?id=jsi-调用)
 分享


> **demo**
``` js

{
  // 分享链接
  xengine.api("com.zkty.jsi.share", "share", {
    channel: "wx_zone",
    type: "link",
    info: {
      url: "https://www.baidu.com",
      title: "testTitle",
      desc: "description",
    },
  },
  (res) => {
      let obj = JSON.parse(res);
	  let code = obj.code;
      console.log(code)       
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
  },
  (res) => {
      let obj = JSON.parse(res);
	  let code = obj.code;
      console.log(code)    
    });

  // 分享图片
  xengine.api("com.zkty.jsi.share", "share", {
    channel: "wx_zone",
    type: "img",
    info: {
      imgData: "https://www.baidu.com",
    },
  },
  (res) => {
      let obj = JSON.parse(res);
	  let code = obj.code;
      console.log(code)    
    });
}
``` 

**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| channel | string | 必填 |  | 当前可用:<br>1. wx_friend 微信联系人<br>2. wx_zone 微信朋友圈 |
| type | string | 必填 |  | 当前可用：<br>1. text 文字<br>2. img 图片<br>3. link 链接<br>4. miniProgram 微信小程序 |
| info | Map\<string,string\> | 必填 |  | 相应分享信息 |

**返回值**
``` js
 {
code: int
}
``` 


    

