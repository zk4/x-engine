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
  dataUrl?: string,
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
    title:"test",
    desc:"testdesc",
    link:"http://www.baidu.com",
    imgUrl:"",
    __event__: (string)=>string,
  }
):ShareResDTO {
  window.share = () => {
    share
      .share({
        __event__: (res) => {
          document.getElementById("debug_text").innerText = JSON.stringify(res);
        },
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = res;
      });
  };
}