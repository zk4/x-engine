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
  // 小程序消息title
  path : string, 
  // 小程序消息title
  title: string,
  // 小程序消息desc
  desc : string,
  // 小程序消息封面图片，小于128k
  imageurl: string,
  // 兼容低版本的网页链接
  link : string;
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
    userName:"gh_d43f693ca31f",
	path:"/pages/media",
	title:"title",
	desc:"desc",
	link:"http://www.baidu.com",
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
        __event__: (res) => {
          document.getElementById("debug_text").innerText = JSON.stringify(res);
        },
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = res;
      });
  };
}