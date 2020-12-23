

**基座扫描测试**
<div id='modulename' style='display:none'>share</div> <img id='qrimg' src='https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=http://192.168.44.52:3000/docs/modules/all/dist/ui/index.html'></img>
<a id='qrlink' href="about:none">link of QR</a>



# JS


version: 0.1.4
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
| type | string |  | link |  (music,video,link) 不填默认为link |
| title | string |  | test |  |
| desc | string |  | testdesc |  |
| link | string |  | http://www.baidu.com |  |
| imageurl | string |  |  |  |
| dataurl | string | true |  |  如果type是music或video，则要提供数据链接，默认为空 |
| channel | string | true | wx_zone | wx_zone (朋友圈) wx_friend(好友) |
| \_\_event\_\_ |  | true |  |  |

    

# iOS


# android


