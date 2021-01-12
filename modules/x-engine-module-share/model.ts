// 命名空间
const moduleID = "com.zkty.module.share";

// dto
interface ShareReqDTO {
  // (music,video,link) 不填默认为link
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
  miniProgramType?:number,
  __event__?: (string)=>void,

}

interface ShareResDTO {
  // todo 
  code: string,
  errStr:string,
  type:string
}

function share(
  ShareReqDTO: ShareReqDTO = {
    type:"link",
  }
):ShareResDTO {
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

function shareForOpenWXMiniProgram(
  MiniProgramReqDTO: MiniProgramReqDTO = {
    miniProgramType:0
  }
):ShareResDTO {
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