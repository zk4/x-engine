

JSI Id: com.zkty.jsi.share

version: 0.1.13



## share
[`sync`](/docs/modules/模块-规范?id=jsi-调用),[`async`](/docs/modules/模块-规范?id=jsi-调用)
> 分享
**demo**
``` js
{
  xengine.api(
    "com.zkty.jsi.share",
    "share",
    {
      channel: "wx_zone",
      type: "link",
	  info:{
		  url:"https://www.baidu.com",
		  title:"testTitle",
		  desc:"description"
	  }
      
    }
  );
}
``` 

**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| channel | string | 必填 |  | 当前可用:<br>1. wx_friend 微信联系人<br>2. wx_zone 微信朋友圈 |
| type | string | 必填 |  | 当前可用：<br>1. text 文字<br>2. img 图片<br>3. link 链接<br>4. miniProgram 微信小程序 |
| info | Map\<string,string\> | 必填 |  | 相应分享信息 |
**无返回值**


    