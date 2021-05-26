
import gmshare from './index.js'
import xengine from "@zkty-team/x-engine-core";

window.test_openShareUi = () => {

 xengine.api("com.zkty.jsi.gmshare", "openShareUi", {"shopWechatGroupImgUrl":"","channelList":[
        {
            "channel":"wx_friend",
            "shareType":"miniProgram"
        },
        {
            "channel":"wx_zone",
            "shareType":"miniProgram"
        },
        {
            "channel":"gome",
            "shareType":"miniProgram"
        },
        {
            "channel":"create_poster",
            "shareType":"img"
        }
    ]}, (val) => {
    document.getElementById("debug_text").innerText = JSON.stringify(val);
  });
}
 document.getElementById("test_openShareUi").click()
      window.test_createPoster = () => {

  let val = xengine.api("com.zkty.jsi.gmshare", "createPoster",{
        "posterType":"goods",
        "posterImgUrl":"https://i.picsum.photos/id/658/400/400.jpg?hmac=mo1ioi7RJtmA8U7UCDNYXsibPrMbHXvcnGQe23Hqgl4",
        "shopLogoUrl":"https://i.picsum.photos/id/658/400/400.jpg?hmac=mo1ioi7RJtmA8U7UCDNYXsibPrMbHXvcnGQe23Hqgl4",
        "shopName":"海报店铺名称",
        "shopAddress":"",
        "rightCornerImg":"https://i.picsum.photos/id/658/400/400.jpg?hmac=mo1ioi7RJtmA8U7UCDNYXsibPrMbHXvcnGQe23Hqgl4",
        "minProgramImg":"https://i.picsum.photos/id/658/400/400.jpg?hmac=mo1ioi7RJtmA8U7UCDNYXsibPrMbHXvcnGQe23Hqgl4",
        "goodsTitle":"海报商品名称",
        "goodsPrice":"¥100.00",
        "activityName":""
    });
  document.getElementById("debug_text").innerText ="同步无返回";
}
 document.getElementById("test_createPoster").click()
      
    