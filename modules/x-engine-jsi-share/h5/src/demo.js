
import share from './index.js'
import xengine from "@zkty-team/x-engine-core";

window.test_share = () => {
 {
  xengine.api("com.zkty.jsi.share", "share", {
    channel: "wx_zone",
    type: "link",
    info: {
      url: "https://www.baidu.com",
      title: "testTitle",
      desc: "description",
    },
  });
}}
 document.getElementById("test_share").click()
        window.test_share2 = () => {
 {
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
  });
}}
 document.getElementById("test_share2").click()
        
    