
`
com.zkty.module.share
`



## share



	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| type | string |  | link |  (music,video,link) 不填默认为link |
| title | string |  |  |  |
| desc | string |  |  |  |
| link | string |  |  |  |
| imageurl | string |  |  |  |
| dataurl | string | true |  |  如果type是music或video，则要提供数据链接，默认为空 |
| channel | string | true |  | wx_zone (朋友圈) wx_friend(好友) |
| \_\_event\_\_ |  | true |  |  |


## shareForOpenWXMiniProgram



	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| userName | string |  |  |  小程序原始id |
| path | string |  |  |  小程序页面路径 |
| title | string |  |  |  小程序消息title |
| desc | string |  |  |  小程序消息desc |
| imageurl | string |  |  |  小程序消息封面图片，小于128k |
| link | string |  |  |  兼容低版本的网页链接 |
| miniProgramType | number | true |  | 小程序版本 0:正式版 1:开发版 2:体验版 |
| \_\_event\_\_ |  | true |  |  |

    