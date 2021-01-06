
version: 0.1.7
``` bash
npm install @zkty-team/x-engine-module-share
```



## share



**demo**
``` js
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
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| type | string | 必填 | link |  (music,video,link) 不填默认为link |
| title | string | 必填 |  |  |
| desc | string | 必填 |  |  |
| link | string | 必填 |  |  |
| imageurl | string | 必填 |  |  |
| dataurl | string | optional |  |  如果type是music或video，则要提供数据链接，默认为空 |
| channel | string | optional |  | wx_zone (朋友圈) wx_friend(好友) |
| \_\_event\_\_ | _0_com.zkty.module.share_DTO | optional |  |  |

**返回值**
**无参数**



    