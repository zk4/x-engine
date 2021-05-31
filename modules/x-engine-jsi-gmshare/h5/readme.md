

JSI Id: com.zkty.jsi.gmshare

version: 0.1.13



## openShareUi
[`async`](/docs/modules/模块-规范?id=jsi-调用)
> 打开分享的渠道UI
**demo**
``` js

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
    ]});

``` 

**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| shopWechatGroupImgUrl | string | optional |  |  |
| channelList | Array\<ChannelDTO\> | 必填 |  | 展示的分享渠道 |
**返回值**
``` js


//分享渠道返回
interface ChannelStatusDTO {

  //分享渠道标签  wx_friend (微信好友) wx_zone（朋友圈）gome（国美） create_poster(生成海报) save_img(保存图片)
  channel: string;
  //分享类型 text (文字) img (图片) link (链接) miniProgram (微信小程序)
  shareType: string;
  //分享图片的base64
  shareImgData?: string;

}
``` 



## createPoster
[`sync`](/docs/modules/模块-规范?id=jsi-调用)
> 创建海报
**demo**
``` js

  xengine.api("com.zkty.jsi.gmshare", "createPoster",{
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

``` 

**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| posterType | string | 必填 |  | 海报类型  goods(商品) shop(店铺) activity(活动) |
| posterImgUrl | string | 必填 |  | 海报图片 |
| shopLogoUrl | string | optional |  | 店铺logo url地址 |
| shopName | string | optional |  | 店铺名称 |
| shopAddress | string | optional |  | 店铺地址 （店铺海报必传） |
| rightCornerImg | string | optional |  | 右下角二维码图片 |
| minProgramImg | string | optional |  | 小程序二维码图片 |
| goodsTitle | string | optional |  | 商品的名称（商品海报必传） |
| goodsPrice | string | optional |  | 商品的价格（商品海报必传） |
| activityName | string | optional |  | 活动名称（活动海报必传） |
**无返回值**


    