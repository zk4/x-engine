
import share from './index.js'
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
} {
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
    