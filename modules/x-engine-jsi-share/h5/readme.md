

JSI Id: com.zkty.jsi.share

version: 0.1.13



## share
[`async`](/docs/modules/模块-规范?id=jsi-调用)
> 分享
**demo**
``` js
 {
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
``` 

**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| channel | string | 必填 |  | wx_zone (朋友圈) wx_friend(好友) |
| type | string | 必填 |  | text (文字) img (图片) link (链接) miniProgram (微信小程序) |
| title | string | optional |  | 标题 |
| desc | string | optional |  | 描述 |
| text | string | optional |  | 文字内容(文字类型必填) |
| imgUrl | string | optional |  | 图片链接 |
| imgData | string | optional |  | base64格式图片数据 |
| url | string | optional |  | 网页链接(链接类型必填) |
| userName | string | optional |  | 小程序原始id |
| path | string | optional |  | 小程序页面路径 |
| link | string | optional |  | 兼容低版本的网页链接 |
| miniProgramType | int | optional |  | 小程序版本 0:正式版 1:开发版 2:体验版 默认为0 |
**返回值**
``` js
string
``` 


    