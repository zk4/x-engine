// 命名空间
const moduleID = "com.zkty.module.share";

// dto
interface ShareReqDTO {
  // (music,video,link) 不填默认为link
  type: string, 
  title: string,
  desc : string,
  link : string,
  imgUrl: string,
  // 如果type是music或video，则要提供数据链接，默认为空
  dataUrl?: string 
}
interface ShareResDTO {
  // todo 
  code: string
  
}

function share(arg:ShareReqDTO={type:"link"}):ShareResDTO {
    window.share = (...args) => {
    share
      .share(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:"+res["code"];
      });
  };
}
