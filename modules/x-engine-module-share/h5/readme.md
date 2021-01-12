
version: 0.1.11
``` bash
npm install @zkty-team/x-engine-module-share
```



## share



**demo**
``` js
 {
  window.share = () => {
    share
      .share({
        title:"test",
        desc:"testdesc",
        link:"http://www.baidu.com",
        imageurl:"",
        channel:"wx_zone",
        __event__: (res) => {
          document.getElementById("debug_text").innerText = JSON.stringify(res);
        },
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = res;
      });
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| type | string | 必填 | link |  (music,video,link) 不填默认为link |
| title | string | 必填 |  |  |
| desc | string | 必填 |  |  |
| link | string | 必填 |  |  |
| imageurl | string | 必填 |  |  |
| dataurl | string | optional |  |  如果type是music或video，则要提供数据链接，默认为空 |
| channel | string | optional |  | wx_zone (朋友圈) wx_friend(好友) |
| \_\_event\_\_ | _0_com.zkty.module.share_DTO | optional |  |  |


参数 object  定义
``` js


// dto
interface ShareReqDTO {

  // (music,
video,
link) 不填默认为link
  type: string,
 
  title: string,

  desc : string,

  link : string,

  imageurl: string,

  // 如果type是music或video，则要提供数据链接，默认为空
  dataurl?: string,

  //wx_zone (朋友圈) wx_friend(好友)
  channel?: string;
  __event__?: (string)=>void,



}
``` 


---------------------
**返回值**
``` js


interface ShareResDTO {

  // todo 
  code: string,

  errStr:string,

  type:string

}
``` 




## shareForOpenWXMiniProgram



**demo**
``` js
 {
  window.shareForOpenWXMiniProgram = () => {
    share
      .shareForOpenWXMiniProgram({
		userName:"gh_d43f693ca31f",
		path:"/pages/media",
        title:"test",
        desc:"testdesc",
        link:"http://www.baidu.com",
        imageurl:"",
        miniProgramType:2,
        __event__: (res) => {
          document.getElementById("debug_text").innerText = JSON.stringify(res);
        },
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = res;
      });
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| userName | string | 必填 |  |  小程序原始id |
| path | string | 必填 |  |  小程序页面路径 |
| title | string | 必填 |  |  小程序消息title |
| desc | string | 必填 |  |  小程序消息desc |
| imageurl | string | 必填 |  |  小程序消息封面图片，小于128k |
| link | string | 必填 |  |  兼容低版本的网页链接 |
| miniProgramType | int | optional |  | 小程序版本 0:正式版 1:开发版 2:体验版 默认为0 |
| \_\_event\_\_ | _1_com.zkty.module.share_DTO | optional |  |  |


参数 object  定义
``` js

// dto
interface MiniProgramReqDTO {

   // 小程序原始id
  userName: string,
 
  // 小程序页面路径
  path : string,
 
  // 小程序消息title
  title: string,

  // 小程序消息desc
  desc : string,

  // 小程序消息封面图片，小于128k
  imageurl: string,

  // 兼容低版本的网页链接
  link : string;
  //小程序版本 0:正式版 1:开发版 2:体验版 默认为0
  miniProgramType?:int,

  __event__?: (string)=>void,



}
``` 


---------------------
**返回值**
``` js


interface ShareResDTO {

  // todo 
  code: string,

  errStr:string,

  type:string

}
``` 



    