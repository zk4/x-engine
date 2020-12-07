// 命名空间
const moduleID = "com.zkty.module.share";

// dto
interface ShareReqDTO {
  // (wexin,weibo) 默认 weixin
  channel:string, 
  // (music,video,link) 默认为link
  type: string, 
  title: string,
  link : string,
  desc? : string,
  imgUrl?: string,
  // 如果type是music或video，则要提供数据链接，默认为空
  dataUrl?: string 
}
interface ShareResDTO {
  // todo 
  code: string
  
}

function share(arg:ShareReqDTO={channel:"wexin",type:"link"}):ShareResDTO {
    window.share = (...args) => {
    share
      .share({
        ...args,
        title:"这是一个测试 title",
        desc:"this is desc",
        link: "https://www.baidu.com"
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:"+res["code"];
      });
  };
}
